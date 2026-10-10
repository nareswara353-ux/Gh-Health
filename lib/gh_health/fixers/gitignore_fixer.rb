module GhHealth
  module Fixers
    class GitignoreFixer
      REQUIRED_PATTERNS = [".env", "vendor/bundle", "node_modules", ".DS_Store"].freeze

      def initialize(repo_path:)
        @repo_path = repo_path
      end

      def call
        missing = REQUIRED_PATTERNS.reject { |p| current_patterns.include?(p) }
        return failure("No patterns missing") if missing.empty?

        append_patterns(missing)
        success("Added: #{missing.join(', ')}")
      rescue StandardError => e
        failure(e.message)
      end

      private

      attr_reader :repo_path

      def gitignore_path
        File.join(repo_path, ".gitignore")
      end

      def current_patterns
        return [] unless File.exist?(gitignore_path)

        File.readlines(gitignore_path).map(&:strip)
      end

      def append_patterns(patterns)
        File.open(gitignore_path, "a") do |f|
          f.puts unless current_patterns.empty?
          patterns.each { |p| f.puts p }
        end
      end

      def success(message)
        { ok: true, checker: "GitignoreChecker", message: message }
      end

      def failure(message)
        { ok: false, checker: "GitignoreChecker", message: message }
      end
    end
  end
end
