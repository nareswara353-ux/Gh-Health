require "json"

module GhHealth
  class Report
    ICONS = { ok: "✅", fail: "❌" }.freeze

    def initialize(audit_result, format: :text)
      @result = audit_result
      @format = format
    end

    def render
      case format
      when :json then render_json
      else render_text
      end
    end

    private

    attr_reader :result, :format

    def render_text
      lines = []
      lines << header
      lines << ""
      result[:results].each { |r| lines << format_result(r) }
      lines << ""
      lines << summary
      lines.join("\n")
    end

    def render_json
      JSON.pretty_generate(
        repo_path: result[:repo_path],
        passed: result[:passed],
        failed: result[:failed],
        results: result[:results]
      )
    end

    def header
      "=== gh-health audit: #{result[:repo_path]} ==="
    end

    def format_result(result)
      icon = result[:ok] ? ICONS[:ok] : ICONS[:fail]
      line = "#{icon} [#{result[:checker]}] #{result[:message]}"
      return line unless result[:details]

      "#{line}\n   → #{result[:details].inspect}"
    end

    def summary
      total = result[:results].size
      "#{result[:passed]}/#{total} passed, #{result[:failed]} failed"
    end
  end
end
