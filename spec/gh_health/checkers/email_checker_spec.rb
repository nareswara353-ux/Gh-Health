require "spec_helper"
require_relative "../../../lib/gh_health/checkers/email_checker"

RSpec.describe GhHealth::Checkers::EmailChecker do
  let(:checker) { described_class.new(repo_path: "/tmp", github_email: "test@example.com") }

  it "passes when email matches" do
    allow(checker).to receive(:run_git).and_return("test@example.com\n")
    expect(checker.call[:ok]).to be true
  end

  it "fails when email mismatches" do
    allow(checker).to receive(:run_git).and_return("other@example.com\n")
    result = checker.call
    expect(result[:ok]).to be false
    expect(result[:message]).to include("Email mismatch")
  end

  it "passes when github_email not provided" do
    result = described_class.new(repo_path: "/tmp").call
    expect(result[:ok]).to be true
  end
end
