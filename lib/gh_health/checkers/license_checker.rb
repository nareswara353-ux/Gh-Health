require_relative "base"

module GhHealth
  module Checkers
    class LicenseChecker < Base
      LICENSE_PATTERNS = %w[LICENSE LICENSE.md LICENSE.txt MIT-LICENSE].freeze

      def call
        found = LICENSE_PATTERNS.find { |name| File.exist?(File.join(repo_path, name)) }

        if found
          success("License file found: #{found}")
        else
          failure("No LICENSE file — GitHub profile will not show license badge")
        end
      end
    end
  end
end
