require "spec_helper"
require "tmpdir"
require_relative "../../lib/gh_health/config"

RSpec.describe GhHealth::Config do
  let(:tmpdir) { Dir.mktmpdir }
  let(:path) { File.join(tmpdir, "config.yml") }
  let(:config) { described_class.new(path) }

  after { FileUtils.rm_rf(tmpdir) }

  it "returns nil when no config exists" do
    expect(config.github_email).to be_nil
  end

  it "returns false when config file missing" do
    expect(config.exists?).to be false
  end

  it "saves and loads github_email" do
    config.github_email = "test@example.com"
    expect(config.github_email).to eq("test@example.com")
    expect(config.exists?).to be true
  end

  it "persists across instances" do
    config.github_email = "persist@example.com"
    other = described_class.new(path)
    expect(other.github_email).to eq("persist@example.com")
  end
end
