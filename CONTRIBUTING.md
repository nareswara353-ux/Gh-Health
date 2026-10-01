# Contributing to gh-health

Thanks for your interest in improving `gh-health`!

## Development setup

```bash
git clone https://github.com/nareswara353-ux/Gh-Health.git
cd gh-health
bundle install
bundle exec rspec
Adding a new checker
Create lib/gh_health/checkers/<name>_checker.rb

Inherit from GhHealth::Checkers::Base (or implement #call returning { ok:, message: })

Register it in lib/gh_health/checkers.rb inside ALL

Add spec in spec/gh_health/checkers/<name>_checker_spec.rb

Update CHANGELOG.md under [Unreleased]

Checker contract
Each checker must:

Accept repo_path: keyword argument (default .)

Return a Hash with keys :ok (Boolean) and :message (String)

Optionally return :details Hash for extra context

Never raise — rescue internally and return { ok: false, message: ... }

Code style
RuboCop enforced (see .rubocop.yml)

100% test coverage for new checkers

No comments in code — use expressive naming

Prefer Shellwords.escape when interpolating paths into shell commands

Commit convention
text
<type>(<scope>): <description>

feat, fix, docs, test, refactor, ci, chore, style
Pull request checklist
□ bundle exec rspec passes
□ bundle exec rubocop clean
□ CHANGELOG.md updated
□ New checker registered in Checkers::ALL
□ Specs added