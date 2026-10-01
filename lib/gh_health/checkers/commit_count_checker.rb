require_relative "base"
require "time"

module GhHealth
  module Checkers
    class CommitCountChecker < Base
      DAYS_WINDOW = 30

      def call
        commits = recent_commits
        active_days = commits.map { |c| c[:date] }.uniq.size

        success(
          "#{commits.size} commits across #{active_days} active day(s) in last #{DAYS_WINDOW} days",
          details: {
            total_commits: commits.size,
            active_days: active_days,
            window_days: DAYS_WINDOW
          }
        )
      end

      private

      def recent_commits
        since = (Time.now - (DAYS_WINDOW * 86_400)).iso8601
        output = run_git("log --since='#{since}' --format='%H|%ad' --date=short")
        output.split("\n").filter_map do |line|
          sha, date = line.split("|")
          next if sha.nil? || date.nil?

          { sha: sha.strip, date: date.strip }
        end
      end
    end
  end
end
