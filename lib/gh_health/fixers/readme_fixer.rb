module GhHealth
  module Fixers
    class ReadmeFixer
      def initialize(repo_path:)
        @repo_path = repo_path
      end

      def call
        return failure("README already exists") if File.exist?(File.join(repo_path, "README.md"))

        File.write(File.join(repo_path, "README.md"), template)
        success("Created README.md")
      rescue StandardError => e
        failure(e.message)
      end

      private

      attr_reader :repo_path

      def template
        name = File.basename(repo_path)
        "# #{name}\n\n[Add project description here]\n"
      end

      def success(message)
        { ok: true, checker: "ReadmeChecker", message: message }
      end

      def failure(message)
        { ok: false, checker: "ReadmeChecker", message: message }
      end
    end
  end
end
