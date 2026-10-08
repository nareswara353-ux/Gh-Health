require "spec_helper"
require_relative "../../../lib/gh_health/fixers/email_fixer"

RSpec.describe GhHealth::Fixers::EmailFixer do
  let(:fixer) { described_class.new(repo_path: "/tmp", github_email: "test@example.com") }

  it "applies fix and returns success" do
    allow(fixer).to receive(:system).and_return(true)
    result = fixer.call
    expect(result[:ok]).to be true
    expect(result[:checker]).to eq("EmailChecker")
  end

  it "returns failure when no email provided" do
    result = described_class.new(repo_path: "/tmp", github_email: nil).call
    expect(result[:ok]).to be false
    expect(result[:message]).to include("No GitHub email")
  end
end
