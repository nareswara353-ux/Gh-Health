# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `gh-health` CLI executable with `-p` (path), `-e` (email), `-v` (version) flags
- `ApplicationChecker` base class
- `EmailChecker` — verifies git email matches GitHub verified email
- `DateChecker` — detects future-dated commits (system clock skew)
- `RemoteChecker` — verifies origin points to github.com
- `BranchChecker` — ensures current branch is `main`
- `ForkChecker` — detects fork repositories (GitHub excludes fork contributions)
- `Auditor` orchestrator running all registered checkers
- `Report` formatter with emoji status output
- RSpec test suite for checkers, auditor, and report
- RuboCop config with strict rules

### Fixed
- Escape repo path in git commands to support spaces and special characters

## [0.1.0] - 2026-09-30

### Added
- Initial project skeleton
- Gem structure with gemspec, Gemfile, Rakefile
