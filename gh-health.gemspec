Gem::Specification.new do |spec|
  spec.name = "gh-health"
  spec.version = "0.3.0"
  spec.authors = ["Narezzzs"]
  spec.summary = "Audit git repositories for GitHub contribution graph issues"
  spec.description = "CLI tool to diagnose and fix common issues that prevent commits from appearing in GitHub contribution graphs"
  spec.homepage = "https://github.com/nareswara353-ux/Gh-Health"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  spec.files = Dir["lib/**/*", "bin/*", "README.md", "LICENSE", "CHANGELOG.md"]
  spec.bindir = "bin"
  spec.executables = ["gh-health"]
  spec.require_paths = ["lib"]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.add_dependency "erb"
end
