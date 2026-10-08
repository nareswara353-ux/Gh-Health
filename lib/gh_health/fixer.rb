require_relative "fixers/email_fixer"

module GhHealth
  class Fixer
    def initialize(result:, repo_path: ".", github_email: nil)
      @result = result
      @repo_path = repo_path
      @github_email = github_email
    end

    def call
      fixes = failed_checkers.filter_map { |checker| fix_for(checker) }
      {
        applied: fixes.count { |f| f[:ok] },
        skipped: fixes.count { |f| !f[:ok] },
        details: fixes
      }
    end

    private

    attr_reader :result, :repo_path, :github_email

    def failed_checkers
      result[:results].reject { |r| r[:ok] }.map { |r| r[:checker] }
    end

    def fix_for(checker)
      case checker
      when "EmailChecker" then email_fixer.call
      else { ok: false, checker: checker, message: "No auto-fix available" }
      end
    end

    def email_fixer
      Fixers::EmailFixer.new(repo_path: repo_path, github_email: github_email)
    end
  end
end
