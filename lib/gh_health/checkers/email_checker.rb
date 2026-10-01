require_relative "base"

module GhHealth
  module Checkers
    class EmailChecker < Base
      def initialize(repo_path: ".", github_email: nil)
        super(repo_path: repo_path)
        @github_email = github_email
      end

      def call
        return success("No GitHub email provided, skipping check") unless github_email

        if local_email.empty?
          failure("No git user.email configured for this repo")
        elsif local_email.downcase == github_email.downcase
          success("Email matches GitHub account")
        else
          failure("Email mismatch: local=#{local_email}, github=#{github_email}")
        end
      end

      private

      attr_reader :github_email

      def local_email
        @local_email ||= run_git("config user.email").strip
      end
    end
  end
end
