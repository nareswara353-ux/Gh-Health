require "spec_helper"
require "tmpdir"
require_relative "../../../lib/gh_health/checkers/license_checker"

RSpec.describe GhHealth::Checkers::LicenseChecker do
  it "passes when LICENSE exists" do
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "LICENSE"), "MIT")
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be true
      expect(result[:message]).to include("LICENSE")
    end
  end

  it "fails when no LICENSE" do
    Dir.mktmpdir do |dir|
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be false
    end
  end
end
