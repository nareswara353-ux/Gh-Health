# gh-health

[![CI](https://github.com/nareswara353-ux/Gh-Health/actions/workflows/ci.yml/badge.svg)](https://github.com/nareswara353-ux/Gh-Health/actions/workflows/ci.yml)

CLI tool to audit git repositories for common issues that prevent commits from appearing in your GitHub contribution graph.

## Why

If you've ever pushed dozens of commits and still see **0 contributions**, `gh-health` diagnoses the most common causes in seconds:

- ❌ **Email mismatch** — local git email ≠ verified GitHub email
- ❌ **Future-dated commits** — system clock skew makes commits "in the future"
- ❌ **Not a GitHub remote** — origin points somewhere else
- ❌ **Wrong branch** — you're on a non-default branch
- ❌ **Fork repo** — GitHub ignores contribution to forks
- ℹ️ **Private repo reminder** — ensure "Include private contributions" is enabled
- ℹ️ **Activity summary** — total commits and active days in last 30 days
- ℹ️ **README presence** — GitHub profile shows project description only with a README

## Installation

```bash
git clone https://github.com/nareswara353-ux/Gh-Health.git
cd gh-health
bundle install
chmod +x bin/gh-health
Usage
bash
# Audit current repo
bin/gh-health

# Audit a specific repo with GitHub email check
bin/gh-health -p ~/my-project -e you@example.com

# JSON output (for CI integration)
bin/gh-health --json

# Show version
bin/gh-health --version
Example output
text
=== gh-health audit: /home/user/my-project ===

✅ [EmailChecker] Email matches GitHub account
✅ [DateChecker] No future-dated commits detected
✅ [RemoteChecker] Origin points to GitHub: git@github.com:user/repo.git
✅ [BranchChecker] On default branch (main)
✅ [ForkChecker] Repository is not a fork
✅ [VisibilityChecker] Repository visibility must be checked on GitHub
✅ [CommitCountChecker] 24 commits across 6 active day(s) in last 30 days
✅ [ReadmeChecker] README found: README.md

8/8 passed, 0 failed
JSON output
json
{
  "repo_path": ".",
  "passed": 8,
  "failed": 0,
  "results": [
    { "ok": true, "message": "Email matches GitHub account", "checker": "EmailChecker" }
  ]
}
Checkers
Checker	Purpose
EmailChecker	Verifies git email = GitHub verified email
DateChecker	Detects future-dated commits (system clock skew)
RemoteChecker	Ensures origin points to github.com
BranchChecker	Ensures current branch is main
ForkChecker	Detects fork repositories (excluded from contributions)
VisibilityChecker	Reminds to enable private contributions
CommitCountChecker	Shows commits and active days in last 30 days
ReadmeChecker	Verifies README presence for profile display
Exit Codes
0 — all checks passed

1 — one or more checks failed

Roadmap
☑ Core checkers (email, date, remote, branch, fork)
☑ Additional checkers (visibility, commit count, readme)
☑ JSON output format
□ Publish to RubyGems
□ GitHub API integration (verified email auto-detection)
□ --fix flag for auto-remediation
□ GitLab support
□ Homebrew formula
Development
bash
bundle install
bundle exec rspec
bundle exec rubocop
See CONTRIBUTING.md for adding new checkers.

License
MIT — see LICENSE.

Changelog
See CHANGELOG.md.