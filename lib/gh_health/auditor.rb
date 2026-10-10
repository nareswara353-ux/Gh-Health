require_relative "checkers"
module GhHealth
  class Auditor
    def initialize(repo_path: ".", github_email: nil)
      @repo_path = repo_path
      @github_email = github_email
    end

    def call
      results = checkers.map { |checker| run_checker(checker) }

      {
        repo_path: repo_path,
        results: results,
        passed: results.count { |r| r[:ok] },
        failed: results.count { |r| !r[:ok] }
      }
    end

    private

    attr_reader :repo_path, :github_email

    def checkers
      Checkers::ALL.map do |klass|
        if klass == Checkers::EmailChecker
          klass.new(repo_path: repo_path, github_email: github_email)
        else
          klass.new(repo_path: repo_path)
        end
      end
    end

    def run_checker(checker)
      result = checker.call
      result.merge(checker: checker.class.name.split("::").last)
    rescue StandardError => e
      { ok: false, message: "Checker error: #{e.message}", checker: checker.class.name }
    end
  end
end
