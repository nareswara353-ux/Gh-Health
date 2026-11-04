# gh-health

[![CI](https://github.com/nareswara353-ux/Gh-Health/actions/workflows/ci.yml/badge.svg)](https://github.com/nareswara353-ux/Gh-Health/actions/workflows/ci.yml)
![Coverage](https://img.shields.io/badge/coverage-88%25-yellowgreen)

CLI tool to audit git repositories for common issues that prevent commits from appearing in your GitHub contribution graph.

## Why

If you've ever pushed dozens of commits and still see **0 contributions**, `gh-health` diagnoses the most common causes in seconds:

- ❌ **Email mismatch** -- local git email ≠ verified GitHub email
- ❌ **Future-dated commits** -- system clock skew makes commits "in the future"
- ❌ **Not a GitHub remote** -- origin points somewhere else
- ❌ **Wrong branch** -- you're on a non-default branch
- ❌ **Fork repo** -- GitHub ignores contribution to forks
- ℹ️ **Private repo reminder** -- ensure "Include private contributions" is enabled
- ℹ️ **Activity summary** -- total commits and active days in last 30 days
- ℹ️ **README presence** -- GitHub profile shows project description only with a README
- ℹ️ **LICENSE presence** -- GitHub profile shows license badge
- ℹ️ **Gitignore patterns** -- prevent accidental commit of .env, node_modules, vendor/bundle

## Installation

```bash
git clone https://github.com/nareswara353-ux/Gh-Health.git
cd gh-health
bundle install
chmod +x bin/gh-health
```

## Usage

```bash
# Audit current repo
bin/gh-health

# Audit a specific repo with GitHub email check
bin/gh-health -p ~/my-project -e you@example.com

# Persist email in ~/.config/gh-health/config.yml
bin/gh-health --email you@example.com --save-email

# Auto-detect email from GitHub API (requires GITHUB_TOKEN env)
bin/gh-health --username your-username --auto-detect-email

# Attempt to auto-fix failed checks (currently: EmailChecker)
bin/gh-health --fix -e you@example.com

# Batch audit — scan all git repos in a directory
bin/gh-health --batch -p ~/Projects -e you@example.com

# Batch fix — auto-fix README, LICENSE, and .gitignore issues across all repos
bin/gh-health --batch --fix -p ~/Projects -e you@example.com

# JSON output (for CI integration)
bin/gh-health --json

# List all available checkers
bin/gh-health --list

# Show version
bin/gh-health --version
```

### Example output

```
=== gh-health audit: /home/user/my-project ===

✅ [EmailChecker] Email matches GitHub account
✅ [DateChecker] No future-dated commits detected
✅ [RemoteChecker] Origin points to GitHub: git@github.com:user/repo.git

✅ [VisibilityChecker] Repository visibility must be checked on GitHub
✅ [CommitCountChecker] 24 commits across 6 active day(s) in last 30 days
✅ [ReadmeChecker] README found: README.md

10/10 passed, 0 failed
```

## Checkers

| Checker | Purpose |
|---------|---------|
| `EmailChecker` | Verifies git email = GitHub verified email |
| `DateChecker` | Detects future-dated commits |
| `RemoteChecker` | Ensures origin points to github.com |
| `BranchChecker` | Ensures current branch is `main` |
| `ForkChecker` | Detects fork repositories |
| `VisibilityChecker` | Reminds to enable private contributions |
| `CommitCountChecker` | Shows commits and active days in last 30 days |
| `ReadmeChecker` | Verifies README presence |
| `LicenseChecker` | Verifies LICENSE file presence |
| `GitignoreChecker` | Checks recommended .gitignore patterns |

## Fixers

| Fixer | Purpose |
|-------|---------|
| `EmailFixer` | Sets git user.email to GitHub email |
| `ReadmeFixer` | Creates README.md template |
| `LicenseFixer` | Creates MIT LICENSE file |
| `GitignoreFixer` | Appends missing .gitignore patterns |

## Development

```bash
bundle install
bundle exec rspec              # runs 42 examples with coverage
bundle exec rubocop            # enforces code style
ruby scripts/coverage_badge.rb # regenerates coverage SVG badge
```

### Test Coverage

Current coverage: **88%** (428/486 lines) with 80% minimum enforced via SimpleCov.

Coverage report generated at `coverage/index.html` after each test run.

## Exit Codes

- `0` — all checks passed
- `1` — one or more checks failed

## Roadmap

- [x] Core checkers (email, date, remote, branch, fork)
- [x] Additional checkers (visibility, commit count, readme, license, gitignore)
- [x] JSON output format
- [x] Config persistence
- [x] GitHub API integration (verified email auto-detection)
- [x] `--fix` flag for auto-remediation
- [x] Batch mode + batch auto-fix
- [ ] Publish to RubyGems
- [ ] GitLab support
- [ ] Homebrew formula

## License

MIT — see [LICENSE](LICENSE).

## Changelog

See [CHANGELOG.md](CHANGELOG.md).
