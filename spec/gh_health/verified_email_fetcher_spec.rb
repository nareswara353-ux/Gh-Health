require "spec_helper"
require_relative "../../lib/gh_health/verified_email_fetcher"

RSpec.describe GhHealth::VerifiedEmailFetcher do
  let(:client) { instance_double(GhHealth::GitHubClient) }
  let(:fetcher) { described_class.new(username: "testuser", client: client) }

  describe "#call" do
    it "returns first verified email" do
      allow(client).to receive(:verified_emails).with("testuser").and_return(["a@example.com", "b@example.com"])
      expect(fetcher.call).to eq("a@example.com")
    end

    it "returns nil when no verified emails" do
      allow(client).to receive(:verified_emails).with("testuser").and_return([])
      expect(fetcher.call).to be_nil
    end

    it "returns nil on error" do
      allow(client).to receive(:verified_emails).and_raise(StandardError)
      expect(fetcher.call).to be_nil
    end
  end
end
