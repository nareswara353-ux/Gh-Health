require "spec_helper"
require_relative "../../../lib/gh_health/checkers/date_checker"

RSpec.describe GhHealth::Checkers::DateChecker do
  let(:checker) { described_class.new(repo_path: "/tmp") }

  it "passes when no future commits" do
    allow(checker).to receive(:`).and_return("abc123|#{Time.now.to_i}\n")
    expect(checker.call[:ok]).to be true
  end

  it "fails when future commit detected" do
    future = Time.now.to_i + 3600
    allow(checker).to receive(:`).and_return("abc123|#{future}\n")
    result = checker.call
    expect(result[:ok]).to be false
    expect(result[:details].size).to eq(1)
  end
end
