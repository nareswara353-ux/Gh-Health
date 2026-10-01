require "spec_helper"
require "json"
require_relative "../../lib/gh_health"

RSpec.describe GhHealth::Report do
  let(:result) do
    {
      repo_path: ".",
      results: [
        { ok: true, message: "Email OK", checker: "EmailChecker" },
        { ok: false, message: "Fork detected", checker: "ForkChecker" }
      ],
      passed: 1,
      failed: 1
    }
  end

  describe "text format" do
    it "renders header with repo path" do
      output = described_class.new(result).render
      expect(output).to include("gh-health audit")
      expect(output).to include("1/2 passed")
    end

    it "shows pass and fail icons" do
      output = described_class.new(result).render
      expect(output).to include("✅")
      expect(output).to include("❌")
    end
  end

  describe "json format" do
    it "renders valid JSON" do
      output = described_class.new(result, format: :json).render
      parsed = JSON.parse(output)
      expect(parsed["passed"]).to eq(1)
      expect(parsed["failed"]).to eq(1)
      expect(parsed["results"].size).to eq(2)
    end

    it "includes checker names" do
      output = described_class.new(result, format: :json).render
      parsed = JSON.parse(output)
      names = parsed["results"].map { |r| r["checker"] }
      expect(names).to include("EmailChecker", "ForkChecker")
    end
  end
end
