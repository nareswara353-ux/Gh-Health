module GhHealth
  class Report
    ICONS = { ok: "✅", fail: "❌" }.freeze

    def initialize(audit_result, color: true)
      @result = audit_result
      @color = color
    end

    def render
      lines = []
      lines << header
      lines << ""
      @result[:results].each { |r| lines << format_result(r) }
      lines << ""
      lines << summary
      lines.join("\n")
    end

    private

    def header
      "=== gh-health audit: #{@result[:repo_path]} ==="
    end

    def format_result(result)
      icon = result[:ok] ? ICONS[:ok] : ICONS[:fail]
      line = "#{icon} [#{result[:checker]}] #{result[:message]}"
      return line unless result[:details]

      "#{line}\n   → #{result[:details].inspect}"
    end

    def summary
      total = @result[:results].size
      passed = @result[:passed]
      failed = @result[:failed]
      "#{passed}/#{total} passed, #{failed} failed"
    end
  end
end
