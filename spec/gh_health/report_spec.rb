require "spec_helper"
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
