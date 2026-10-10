require "spec_helper"
require "tmpdir"
require_relative "../../lib/gh_health/batch_auditor"

RSpec.describe GhHealth::BatchAuditor do
  it "returns empty result when no repos found" do
    Dir.mktmpdir do |dir|
      result = described_class.new(base_path: dir).call
      expect(result[:total]).to eq(0)
      expect(result[:results]).to eq([])
    end
  end

  it "audits each git repo in the directory" do
    Dir.mktmpdir do |dir|
      repo = File.join(dir, "repo-a")
      Dir.mkdir(repo)
      Dir.mkdir(File.join(repo, ".git"))

      result = described_class.new(base_path: dir).call
      expect(result[:total]).to eq(1)
      expect(result[:results].first[:repo_path]).to eq(repo)
    end
  end

  it "skips non-git directories" do
    Dir.mktmpdir do |dir|
      Dir.mkdir(File.join(dir, "not-a-repo"))

      result = described_class.new(base_path: dir).call
      expect(result[:total]).to eq(0)
    end
  end
end
