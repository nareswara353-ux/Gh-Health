require_relative "base"
require "time"

module GhHealth
  module Checkers
    class DateChecker < Base
      FUTURE_THRESHOLD_SECONDS = 300

      def call
        future_commits = detect_future_commits

        if future_commits.empty?
          success("No future-dated commits detected")
        else
          failure(
            "#{future_commits.size} future-dated commit(s) found",
            future_commits
          )
        end
      end

      private

      def detect_future_commits
        now = Time.now.to_i
        run_git('log --format="%H|%ct"').split("\n").filter_map do |line|
          sha, timestamp = line.split("|")
          next if timestamp.nil?

          commit_time = timestamp.to_i
          next unless commit_time > now + FUTURE_THRESHOLD_SECONDS

          { sha: sha.strip, date: Time.at(commit_time).iso8601 }
        end
      end
    end
  end
end
