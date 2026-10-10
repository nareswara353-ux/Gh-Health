require "spec_helper"
require "tmpdir"
require_relative "../../../lib/gh_health/fixers/gitignore_fixer"

RSpec.describe GhHealth::Fixers::GitignoreFixer do
  it "creates .gitignore with all patterns when missing" do
    Dir.mktmpdir do |dir|
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be true
      content = File.read(File.join(dir, ".gitignore"))
      expect(content).to include(".env", "vendor/bundle", "node_modules", ".DS_Store")
    end
  end

  it "appends only missing patterns" do
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, ".gitignore"), ".env\n")
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be true
      content = File.read(File.join(dir, ".gitignore"))
      expect(content.scan(".env").size).to eq(1)
      expect(content).to include("node_modules")
    end
  end
end
