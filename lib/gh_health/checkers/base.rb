require "shellwords"

module GhHealth
  module Checkers
    class Base
      def initialize(repo_path: ".")
        @repo_path = repo_path
      end

      def call
        raise NotImplementedError, "#{self.class} must implement #call"
      end

      private

      attr_reader :repo_path

      def run_git(args)
        `git -C #{Shellwords.escape(repo_path)} #{args} 2>/dev/null`
      end

      def success(message, details = nil)
        result = { ok: true, message: message }
        result[:details] = details if details
        result
      end

      def failure(message, details = nil)
        result = { ok: false, message: message }
        result[:details] = details if details
        result
      end
    end
  end
end
