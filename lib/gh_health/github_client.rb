require "net/http"
require "json"
require "uri"

module GhHealth
  class GitHubClient
    API_BASE = "https://api.github.com".freeze

    def initialize(token: nil)
      @token = token || ENV.fetch("GITHUB_TOKEN", nil)
    end

    def verified_emails(username)
      response = get("/users/#{username}/emails")
      return [] unless response

      response.select { |e| e["verified"] }.map { |e| e["email"] }
    end

    def user(username)
      get("/users/#{username}")
    end

    private

    attr_reader :token

    def get(path)
      uri = URI.join(API_BASE, path)
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/vnd.github+json"
      request["Authorization"] = "Bearer #{token}" if token

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      return nil unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    rescue StandardError
      nil
    end
  end
end
