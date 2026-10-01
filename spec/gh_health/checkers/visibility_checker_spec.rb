require "spec_helper"
require_relative "../../../lib/gh_health/checkers/visibility_checker"

RSpec.describe GhHealth::Checkers::VisibilityChecker do
  let(:checker) { described_class.new(repo_path: "/tmp") }

  it "passes when origin exists" do
    allow(checker).to receive(:run_git).and_return("git@github.com:user/repo.git\n")
    result = checker.call
    expect(result[:ok]).to be true
  end

  it "fails when no origin remote" do
    allow(checker).to receive(:run_git).and_return("")
    result = checker.call
    expect(result[:ok]).to be false
  end
end
