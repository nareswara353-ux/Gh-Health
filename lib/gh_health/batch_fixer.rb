require_relative "fixers/email_fixer"
require_relative "fixers/readme_fixer"
require_relative "fixers/license_fixer"
require_relative "fixers/gitignore_fixer"

module GhHealth
  class BatchFixer
    def initialize(batch_result:, github_email: nil)
      @batch_result = batch_result
      @github_email = github_email
    end

    def call
      results = batch_result[:results].map { |r| fix_repo(r) }
      {
        total: results.size,
        fixed: results.count { |r| r[:applied].positive? },
        details: results
      }
    end

    private

    attr_reader :batch_result, :github_email

    def fix_repo(repo_result)
      repo_path = repo_result[:repo_path]
      fixes = repo_result[:results].reject { |r| r[:ok] }.filter_map do |failed|
        apply_fix(failed[:checker], repo_path)
      end

      {
        repo_path: repo_path,
        applied: fixes.count { |f| f[:ok] },
        skipped: fixes.count { |f| !f[:ok] },
        fixes: fixes
      }
    end

    def apply_fix(checker, repo_path)
      case checker
      when "EmailChecker" then Fixers::EmailFixer.new(repo_path: repo_path, github_email: github_email).call
      when "ReadmeChecker" then Fixers::ReadmeFixer.new(repo_path: repo_path).call
      when "LicenseChecker" then Fixers::LicenseFixer.new(repo_path: repo_path).call
      when "GitignoreChecker" then Fixers::GitignoreFixer.new(repo_path: repo_path).call
      else { ok: false, checker: checker, message: "No auto-fix available" }
      end
    end
  end
end
