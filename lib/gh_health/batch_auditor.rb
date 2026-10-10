require_relative "auditor"

module GhHealth
  class BatchAuditor
    def initialize(base_path:, github_email: nil)
      @base_path = base_path
      @github_email = github_email
    end

    def call
      repos = find_repos
      return { total: 0, results: [] } if repos.empty?

      results = repos.map { |path| audit_repo(path) }
      {
        total: results.size,
        passed: results.count { |r| r[:failed].zero? },
        failed: results.count { |r| r[:failed].positive? },
        results: results
      }
    end

    private

    attr_reader :base_path, :github_email

    def find_repos
      Dir.glob(File.join(base_path, "*")).select do |path|
        File.directory?(path) && File.directory?(File.join(path, ".git"))
      end.sort
    end

    def audit_repo(path)
      Auditor.new(repo_path: path, github_email: github_email).call
    end
  end
end
