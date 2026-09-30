require "shellwords"

module GhHealth
  module Checkers
    class RemoteChecker
      def initialize(repo_path: ".")
        @repo_path = repo_path
      end

      def call
        remotes = list_remotes
        return failure("No git remote configured") if remotes.empty?

        origin = remotes.find { |r| r[:name] == "origin" }
        return failure("No origin remote found") unless origin

        if origin[:url].include?("github.com")
          { ok: true, message: "Origin points to GitHub: #{origin[:url]}" }
        else
          { ok: false, message: "Origin does not point to GitHub: #{origin[:url]}" }
        end
      end

      private

      attr_reader :repo_path

      def list_remotes
        output = `git -C #{Shellwords.escape(repo_path)} remote -v 2>/dev/null`
        output.split("\n").filter_map do |line|
          parts = line.split
          next unless parts.size >= 2

          { name: parts[0], url: parts[1] }
        end.uniq
      end

      def failure(message)
        { ok: false, message: message }
      end
    end
  end
end
