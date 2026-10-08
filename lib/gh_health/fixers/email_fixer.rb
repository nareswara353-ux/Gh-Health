require "shellwords"

module GhHealth
  module Fixers
    class EmailFixer
      def initialize(repo_path:, github_email:)
        @repo_path = repo_path
        @github_email = github_email
      end

      def call
        return failure("No GitHub email provided") if github_email.nil?

        system(
          "git", "-C", repo_path, "config", "user.email", github_email,
          out: File::NULL, err: File::NULL
        )
        success("Set git email to #{github_email}")
      rescue StandardError => e
        failure(e.message)
      end

      private

      attr_reader :repo_path, :github_email

      def success(message)
        { ok: true, checker: "EmailChecker", message: message }
      end

      def failure(message)
        { ok: false, checker: "EmailChecker", message: message }
      end
    end
  end
end
