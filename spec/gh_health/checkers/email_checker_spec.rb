require "spec_helper"
require_relative "../../../lib/gh_health/checkers/email_checker"

RSpec.describe GhHealth::Checkers::EmailChecker do
  let(:repo_path) { "/tmp" }

  before do
    allow_any_instance_of(described_class).to receive(:`).and_return("test@example.com\n")
  end

  it "passes when email matches" do
    result = described_class.new(repo_path: repo_path, github_email: "test@example.com").call
    expect(result[:ok]).to be true
  end

  it "fails when email mismatches" do
    result = described_class.new(repo_path: repo_path, github_email: "other@example.com").call
    expect(result[:ok]).to be false
    expect(result[:message]).to include("Email mismatch")
  end

  it "passes when github_email not provided" do
    result = described_class.new(repo_path: repo_path).call
    expect(result[:ok]).to be true
  end
end
