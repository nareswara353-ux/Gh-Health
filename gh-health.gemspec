Gem::Specification.new do |spec|
  spec.name = "gh-health"
  spec.version = "0.1.0"
  spec.authors = ["Narezzzs"]
  spec.summary = "Audit git repositories for GitHub contribution graph issues"
  spec.description = "CLI tool to diagnose and fix common issues that prevent commits from appearing in GitHub contribution graphs"
  spec.homepage = "https://github.com/nareswara353-ux/gh-health"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  spec.files = Dir["lib/**/*", "bin/*", "README.md", "LICENSE"]
  spec.bindir = "bin"
  spec.executables = ["gh-health"]
  spec.require_paths = ["lib"]

  spec.add_dependency "erb"
  spec.metadata['rubygems_mfa_required'] = 'true'
end
