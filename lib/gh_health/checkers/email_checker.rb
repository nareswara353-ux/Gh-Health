module GhHealth
  module Checkers
    class EmailChecker
      def initialize(repo_path: ".", github_email: nil)
        @repo_path = repo_path
        @github_email = github_email
      end

      def call
        return success unless github_email

        if local_email.nil?
          failure("No git user.email configured")
        elsif local_email.downcase == github_email.downcase
          success
        else
          failure("Email mismatch: local=#{local_email}, github=#{github_email}")
        end
      end

      private

      attr_reader :repo_path, :github_email

      def local_email
        @local_email ||= `git -C #{repo_path} config user.email 2>/dev/null`.strip
      end

      def success
        { ok: true, message: "Email matches GitHub account" }
      end

      def failure(message)
        { ok: false, message: message }
      end
    end
  end
end
