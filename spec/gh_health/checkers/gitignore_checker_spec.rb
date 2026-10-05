require "spec_helper"
require "tmpdir"
require_relative "../../../lib/gh_health/checkers/gitignore_checker"

RSpec.describe GhHealth::Checkers::GitignoreChecker do
  it "passes when all patterns present" do
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, ".gitignore"), ".env\nvendor/bundle\nnode_modules\n.DS_Store\n")
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be true
    end
  end

  it "fails when patterns missing" do
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, ".gitignore"), ".env\n")
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be false
      expect(result[:details][:missing_patterns]).to include("vendor/bundle")
    end
  end

  it "fails when no .gitignore" do
    Dir.mktmpdir do |dir|
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be false
    end
  end
end
