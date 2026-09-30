require "shellwords"

module GhHealth
  module Checkers
    class ForkChecker
      def initialize(repo_path: ".")
        @repo_path = repo_path
      end

      def call
        if forked?
          {
            ok: false,
            message: "Repository is a fork — GitHub does not count fork contributions",
            details: { upstream: upstream_url }
          }
        else
          { ok: true, message: "Repository is not a fork" }
        end
      end

      private

      attr_reader :repo_path

      def forked?
        !upstream_url.nil?
      end

      def upstream_url
        output = `git -C #{Shellwords.escape(repo_path)} remote -v 2>/dev/null`
        upstream_line = output.split("\n").find { |l| l.start_with?("upstream") }
        upstream_line&.split&.at(1)
      end
    end
  end
end
