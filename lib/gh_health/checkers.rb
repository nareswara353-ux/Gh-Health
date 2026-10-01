require_relative "checkers/base"
require_relative "checkers/email_checker"
require_relative "checkers/date_checker"
require_relative "checkers/remote_checker"
require_relative "checkers/branch_checker"
require_relative "checkers/fork_checker"
require_relative "checkers/visibility_checker"
require_relative "checkers/commit_count_checker"
require_relative "checkers/readme_checker"

module GhHealth
  module Checkers
    ALL = [
      EmailChecker,
      DateChecker,
      RemoteChecker,
      BranchChecker,
      ForkChecker,
      VisibilityChecker,
      CommitCountChecker,
      ReadmeChecker
    ].freeze
  end
end
