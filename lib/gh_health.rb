require_relative "gh_health/version"
require_relative "gh_health/config"
require_relative "gh_health/github_client"
require_relative "gh_health/verified_email_fetcher"
require_relative "gh_health/checkers"
require_relative "gh_health/auditor"
require_relative "gh_health/fixer"
require_relative "gh_health/report"

module GhHealth
  class Error < StandardError; end
end
