require "spec_helper"
require_relative "../../lib/gh_health/github_client"

RSpec.describe GhHealth::GitHubClient do
  let(:client) { described_class.new(token: "test-token") }

  describe "#verified_emails" do
    it "returns verified emails only" do
      response = [
        { "email" => "verified@example.com", "verified" => true },
        { "email" => "unverified@example.com", "verified" => false }
      ]
      allow(client).to receive(:get).and_return(response)

      result = client.verified_emails("testuser")
      expect(result).to eq(["verified@example.com"])
    end

    it "returns empty array on nil response" do
      allow(client).to receive(:get).and_return(nil)
      expect(client.verified_emails("testuser")).to eq([])
    end
  end
end
