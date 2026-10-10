require "spec_helper"
require "tmpdir"
require_relative "../../../lib/gh_health/fixers/license_fixer"

RSpec.describe GhHealth::Fixers::LicenseFixer do
  it "creates LICENSE when missing" do
    Dir.mktmpdir do |dir|
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be true
      expect(File.read(File.join(dir, "LICENSE"))).to include("MIT License")
    end
  end

  it "skips when LICENSE already exists" do
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "LICENSE"), "existing")
      result = described_class.new(repo_path: dir).call
      expect(result[:ok]).to be false
    end
  end
end
