require_relative "gh_health/version"
require_relative "gh_health/auditor"
require_relative "gh_health/report"

module GhHealth
  class Error < StandardError; end
end
