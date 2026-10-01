require "spec_helper"
require_relative "../../../lib/gh_health/checkers/commit_count_checker"

RSpec.describe GhHealth::Checkers::CommitCountChecker do
  let(:checker) { described_class.new(repo_path: "/tmp") }

  it "counts commits and active days" do
    output = "abc|2026-09-28\ndef|2026-09-28\nghi|2026-09-29\n"
    allow(checker).to receive(:run_git).and_return(output)
    result = checker.call
    expect(result[:ok]).to be true
    expect(result[:details][:total_commits]).to eq(3)
    expect(result[:details][:active_days]).to eq(2)
  end

  it "handles empty log" do
    allow(checker).to receive(:run_git).and_return("")
    result = checker.call
    expect(result[:details][:total_commits]).to eq(0)
    expect(result[:details][:active_days]).to eq(0)
  end
end
