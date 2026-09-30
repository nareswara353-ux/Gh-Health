require_relative "checkers/email_checker"
require_relative "checkers/date_checker"
require_relative "checkers/remote_checker"
require_relative "checkers/branch_checker"
require_relative "checkers/fork_checker"

module GhHealth
  module Checkers
    ALL = [
      EmailChecker,
      DateChecker,
      RemoteChecker,
      BranchChecker,
      ForkChecker
    ].freeze
  end
end
