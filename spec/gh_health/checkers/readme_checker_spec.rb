require "spec_helper"
require "tmpdir"
require_relative "../../../lib/gh_health/checkers/readme_checker"

RSpec.describe GhHealth::Checkers::ReadmeChecker do
  it "passes when README.md exists" do
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "README.md"), "# Test")
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be true
      expect(result[:message]).to include("README.md")
    end
  end

  it "fails when no README" do
    Dir.mktmpdir do |dir|
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be false
    end
  end
end
