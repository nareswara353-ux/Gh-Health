require_relative "base"

module GhHealth
  module Checkers
    class VisibilityChecker < Base
      def call
        if remote_url.empty?
          return failure("No origin remote to determine visibility")
        end

        success(
          "Repository visibility must be checked on GitHub — enable 'Include private contributions' if private",
          details: { remote: remote_url }
        )
      end

      private

      def remote_url
        @remote_url ||= run_git("remote get-url origin").strip
      end
    end
  end
end
