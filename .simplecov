SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/"
  add_filter "/bin/"

  add_group "Checkers", "lib/gh_health/checkers"
  add_group "Fixers", "lib/gh_health/fixers"
  add_group "Core", "lib/gh_health"

  minimum_coverage 80
end
