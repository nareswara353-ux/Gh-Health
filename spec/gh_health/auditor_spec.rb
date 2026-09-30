require "spec_helper"
require_relative "../../lib/gh_health"

RSpec.describe GhHealth::Auditor do
  let(:auditor) { described_class.new(repo_path: "/tmp") }

  describe "#call" do
    it "returns structured result" do
      result = auditor.call
      expect(result).to have_key(:repo_path)
      expect(result).to have_key(:results)
      expect(result).to have_key(:passed)
      expect(result).to have_key(:failed)
    end

    it "runs all registered checkers" do
      result = auditor.call
      checker_names = result[:results].map { |r| r[:checker] }
      expect(checker_names).to include("EmailChecker", "DateChecker", "RemoteChecker", "BranchChecker", "ForkChecker")
    end
  end
end
