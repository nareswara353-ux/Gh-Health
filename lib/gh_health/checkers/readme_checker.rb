require_relative "base"
require "shellwords"

module GhHealth
  module Checkers
    class ReadmeChecker < Base
      README_PATTERNS = %w[README.md README README.txt README.rst readme.md].freeze

      def call
        found = README_PATTERNS.find { |name| readme_exists?(name) }

        if found
          success("README found: #{found}")
        else
          failure("No README file found — GitHub profile will not show project description")
        end
      end

      private

      def readme_exists?(filename)
        path = File.join(repo_path, filename)
        File.exist?(path)
      rescue StandardError
        false
      end
    end
  end
end
