require "yaml"
require "fileutils"

module GhHealth
  class Config
    CONFIG_DIR = File.expand_path("~/.config/gh-health")
    CONFIG_FILE = File.join(CONFIG_DIR, "config.yml")

    def initialize(path = CONFIG_FILE)
      @path = path
    end

    def github_email
      data["github_email"]
    end

    def github_email=(value)
      data["github_email"] = value
      save
    end

    def exists?
      File.exist?(path)
    end

    def to_h
      data.dup
    end

    private

    attr_reader :path

    def data
      @data ||= load
    end

    def load
      return {} unless File.exist?(path)

      YAML.safe_load_file(path) || {}
    rescue StandardError
      {}
    end

    def save
      FileUtils.mkdir_p(File.dirname(path))
      File.write(path, data.to_yaml)
      File.chmod(0o600, path)
    end
  end
end
