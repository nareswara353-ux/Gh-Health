require_relative "base"

module GhHealth
  module Checkers
    class GitignoreChecker < Base
      RECOMMENDED_PATTERNS = [
        ".env",
        "vendor/bundle",
        "node_modules",
        ".DS_Store"
      ].freeze

      def call
        return failure("No .gitignore file found") unless gitignore_exists?

        missing = RECOMMENDED_PATTERNS.reject { |pattern| ignored?(pattern) }

        if missing.empty?
          success("All recommended patterns in .gitignore")
        else
          failure(
            "Missing .gitignore patterns: #{missing.join(', ')}",
            { missing_patterns: missing }
          )
        end
      end

      private

      def gitignore_exists?
        File.exist?(File.join(repo_path, ".gitignore"))
      end

      def ignored?(pattern)
        normalized_pattern = pattern.chomp("/")
        lines.any? do |line|
          normalized_line = line.chomp("/")
          normalized_line == normalized_pattern || normalized_line.end_with?("/#{normalized_pattern}")
        end
      rescue StandardError
        false
      end

      def lines
        File.readlines(File.join(repo_path, ".gitignore")).map(&:strip).reject(&:empty?)
      end
    end
  end
end
