require "spec_helper"
require "tmpdir"
require_relative "../../../lib/gh_health/fixers/readme_fixer"

RSpec.describe GhHealth::Fixers::ReadmeFixer do
  it "creates README.md when missing" do
    Dir.mktmpdir do |dir|
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be true
      expect(File.exist?(File.join(dir, "README.md"))).to be true
    end
  end

  it "skips when README already exists" do
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "README.md"), "# Existing")
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be false
      expect(result[:message]).to include("already exists")
    end
  end
end
