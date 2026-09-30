require "time"

module GhHealth
  module Checkers
    class DateChecker
      FUTURE_THRESHOLD_SECONDS = 300

      def initialize(repo_path: ".")
        @repo_path = repo_path
      end

      def call
        future_commits = detect_future_commits

        if future_commits.empty?
          { ok: true, message: "No future-dated commits detected" }
        else
          {
            ok: false,
            message: "#{future_commits.size} future-dated commit(s) found",
            details: future_commits
          }
        end
      end

      private

      attr_reader :repo_path

      def detect_future_commits
        now = Time.now.to_i
        log_output.split("\n").filter_map do |line|
          sha, timestamp = line.split("|")
          next if timestamp.nil?

          commit_time = timestamp.to_i
          next unless commit_time > now + FUTURE_THRESHOLD_SECONDS

          { sha: sha.strip, date: Time.at(commit_time).iso8601 }
        end
      end

      def log_output
        @log_output ||= `git -C #{repo_path} log --format="%H|%ct" 2>/dev/null`
      end
    end
  end
end
