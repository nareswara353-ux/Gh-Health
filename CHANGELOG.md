# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.8.0] - 2026-10-20

### Added
- SimpleCov integration with 88% line coverage
- `scripts/coverage_badge.rb` — SVG badge generator
- Coverage report uploaded as CI artifact (Ruby 3.4)
- Coverage badge embedded in README
- README rewrite with full checkers and fixers tables
- SimpleCov minimum coverage threshold: 80%

### Changed
- RuboCop excludes `scripts/` directory
- Gemfile dev dependencies reordered alphabetically

## [0.7.0] - 2026-10-10

### Added
- `BatchFixer` orchestrator for multi-repo auto-fix
- `Fixers::ReadmeFixer` — creates README.md template
- `Fixers::LicenseFixer` — creates MIT LICENSE
- `Fixers::GitignoreFixer` — appends missing patterns
- `--fix` support in `--batch` mode
- Specs for all new fixers

## [0.6.0] - 2026-10-10

### Added
- `BatchAuditor` — audits all git repositories in a directory
- `BatchReport` — summary formatter for multi-repo output
- `--batch` CLI flag for directory-wide auditing
- Specs for BatchAuditor

### Fixed
- Missing `Checkers` require in `Auditor` when loaded standalone

## [0.5.0] - 2026-10-08

### Added
- `GitHubClient` — lightweight wrapper for GitHub REST API
- `VerifiedEmailFetcher` — auto-detect verified email from GitHub username
- `Fixer` + `Fixers::EmailFixer` — auto-remediation framework
- `--auto-detect-email` CLI flag (requires `--username`)
- `--username` CLI flag for GitHub username input
- `--fix` CLI flag to auto-fix failed checks (EmailChecker supported)
- Specs for GitHubClient, VerifiedEmailFetcher, and EmailFixer

## [0.4.0] - 2026-10-06

### Added
- `Config` module persisting settings to `~/.config/gh-health/config.yml`
- `--save-email` flag to persist GitHub email across runs
- `--list` flag to display all registered checkers
- Automatic email fallback: CLI arg → config file → no check

## [0.3.0] - 2026-10-05

### Added
- `LicenseChecker` — verifies LICENSE file presence for GitHub badge
- `GitignoreChecker` — checks recommended patterns (.env, vendor/bundle, node_modules, .DS_Store)
- GitHub Actions release workflow triggered on version tags

### Fixed
- Normalize trailing slash in gitignore pattern matching

## [0.2.0] - 2026-10-01

### Added
- `VisibilityChecker` — reminds about private contribution settings
- `CommitCountChecker` — shows commits and active days in last 30 days
- `ReadmeChecker` — verifies README presence
- JSON output format (`--json` flag)
- `Report` supports `format: :json`
- `Base` checker class with `run_git` and result helpers

### Changed
- Refactor all checkers to inherit from `Base`

## [0.1.0] - 2026-09-30

### Added
- `gh-health` CLI executable with `-p` (path), `-e` (email), `-v` (version) flags
- `Auditor` orchestrator running all registered checkers
- `EmailChecker` — verifies git email matches GitHub verified email
- `DateChecker` — detects future-dated commits (system clock skew)
- `RemoteChecker` — verifies origin points to github.com
- `BranchChecker` — ensures current branch is `main`
- `ForkChecker` — detects fork repositories (GitHub excludes fork contributions)
- `Report` formatter with emoji status output
- RSpec test suite for checkers, auditor, and report
- RuboCop config with strict rules
- GitHub Actions CI with Ruby 3.2/3.3/3.4 matrix

### Fixed
- Escape repo path in git commands to support spaces and special characters

[Unreleased]: https://github.com/nareswara353-ux/Gh-Health/compare/v0.8.0...HEAD
[0.8.0]: https://github.com/nareswara353-ux/Gh-Health/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/nareswara353-ux/Gh-Health/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/nareswara353-ux/Gh-Health/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/nareswara353-ux/Gh-Health/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/nareswara353-ux/Gh-Health/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/nareswara353-ux/Gh-Health/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/nareswara353-ux/Gh-Health/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/nareswara353-ux/Gh-Health/releases/tag/v0.1.0
