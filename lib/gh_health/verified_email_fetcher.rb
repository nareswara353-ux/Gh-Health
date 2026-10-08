require_relative "github_client"

module GhHealth
  class VerifiedEmailFetcher
    def initialize(username:, token: nil, client: nil)
      @username = username
      @client = client || GitHubClient.new(token: token)
    end

    def call
      emails = client.verified_emails(username)
      return nil if emails.empty?

      emails.first
    rescue StandardError
      nil
    end

    private

    attr_reader :username, :client
  end
end
