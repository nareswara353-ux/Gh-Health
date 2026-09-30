# gh-health

CLI tool to audit git repositories for common issues that prevent commits from appearing in your GitHub contribution graph.

## Why

If you've ever pushed dozens of commits and still see **0 contributions**, `gh-health` diagnoses the most common causes in seconds:

- ❌ **Email mismatch** — local git email ≠ verified GitHub email
- ❌ **Future-dated commits** — system clock skew makes commits "in the future"
- ❌ **Not a GitHub remote** — origin points somewhere else
- ❌ **Wrong branch** — you're on a non-default branch
- ❌ **Fork repo** — GitHub ignores contribution to forks

## Installation

```bash
git clone https://github.com/nareswara353-ux/gh-health.git
cd gh-health
chmod +x bin/gh-health
Usage
bash
# Audit current repo
bin/gh-health

# Audit a specific repo with GitHub email check
bin/gh-health -p ~/my-project -e you@example.com
Example output
text
=== gh-health audit: /home/user/my-project ===

✅ [EmailChecker] Email matches GitHub account
✅ [DateChecker] No future-dated commits detected
✅ [RemoteChecker] Origin points to GitHub: git@github.com:user/repo.git
✅ [BranchChecker] On default branch (main)
❌ [ForkChecker] Repository is a fork — GitHub does not count fork contributions
   → {upstream: "https://github.com/original/repo.git"}

4/5 passed, 1 failed
Exit Codes
0 — all checks passed

1 — one or more checks failed

Development
bash
bundle install
bundle exec rspec
License
MIT
EOF

cat << 'EOF' > LICENSE
MIT License

Copyright (c) 2026 Narezzzs

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.