require "shellwords"

module GhHealth
  module Checkers
    class EmailChecker
      def initialize(repo_path: ".", github_email: nil)
        @repo_path = repo_path
        @github_email = github_email
      end

      def call
        return success unless github_email

        if local_email.nil? || local_email.empty?
          failure("No git user.email configured for this repo")
        elsif local_email.downcase == github_email.downcase
          success
        else
          failure("Email mismatch: local=#{local_email}, github=#{github_email}")
        end
      end

      private

      attr_reader :repo_path, :github_email

      def local_email
        @local_email ||= run_git("config user.email").strip
      end

      def run_git(args)
        `git -C #{Shellwords.escape(repo_path)} #{args} 2>/dev/null`
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
