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
      when "EmailChecker" then fix_email
      else { ok: false, checker: checker, message: "No auto-fix available" }
      end
    end

    def fix_email
      return { ok: false, checker: "EmailChecker", message: "No GitHub email provided" } if github_email.nil?

      system("git", "-C", repo_path, "config", "user.email", github_email, out: File::NULL, err: File::NULL)
      { ok: true, checker: "EmailChecker", message: "Set git email to #{github_email}" }
    rescue StandardError => e
      { ok: false, checker: "EmailChecker", message: e.message }
    end
  end
end
