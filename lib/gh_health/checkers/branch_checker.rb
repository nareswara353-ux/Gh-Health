require "shellwords"

module GhHealth
  module Checkers
    class BranchChecker
      DEFAULT_BRANCH = "main".freeze

      def initialize(repo_path: ".")
        @repo_path = repo_path
      end

      def call
        if current_branch == DEFAULT_BRANCH
          { ok: true, message: "On default branch (#{DEFAULT_BRANCH})" }
        else
          {
            ok: false,
            message: "Not on default branch (currently: #{current_branch})",
            details: { current: current_branch, expected: DEFAULT_BRANCH }
          }
        end
      end

      private

      attr_reader :repo_path

      def current_branch
        @current_branch ||= `git -C #{Shellwords.escape(repo_path)} branch --show-current 2>/dev/null`.strip
      end
    end
  end
end
