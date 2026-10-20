#!/usr/bin/env ruby

require "json"
require "fileutils"

COVERAGE_JSON = "coverage/.last_run.json"
BADGE_OUTPUT = "coverage/badge.svg"

def main
  unless File.exist?(COVERAGE_JSON)
    warn "No coverage data found. Run `bundle exec rspec` first."
    exit 1
  end

  data = JSON.parse(File.read(COVERAGE_JSON))
  percent = data.dig("result", "line").to_f.round(2)
  color = color_for(percent)

  FileUtils.mkdir_p(File.dirname(BADGE_OUTPUT))
  File.write(BADGE_OUTPUT, svg(percent, color))
  puts "Coverage: #{percent}% (#{color}) → #{BADGE_OUTPUT}"
end

def color_for(percent)
  return "brightgreen" if percent >= 95
  return "green" if percent >= 90
  return "yellowgreen" if percent >= 80
  return "yellow" if percent >= 70
  return "orange" if percent >= 60

  "red"
end

def svg(percent, color)
  label = "coverage"
  value = "#{percent}%"
  label_width = 62
  value_width = 46
  total_width = label_width + value_width

  <<~SVG
    <svg xmlns="http://www.w3.org/2000/svg" width="#{total_width}" height="20">
      <linearGradient id="b" x2="0" y2="100%">
        <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
        <stop offset="1" stop-opacity=".1"/>
      </linearGradient>
      <mask id="a">
        <rect width="#{total_width}" height="20" rx="3" fill="#fff"/>
      </mask>
      <g mask="url(#a)">
        <path fill="#555" d="M0 0h#{label_width}v20H0z"/>
        <path fill="#{color}" d="M#{label_width} 0h#{value_width}v20H#{label_width}z"/>
        <path fill="url(#b)" d="M0 0h#{total_width}v20H0z"/>
      </g>
      <g fill="#fff" text-anchor="middle" font-family="DejaVu Sans,Verdana,Geneva,sans-serif" font-size="11">
        <text x="#{label_width / 2}" y="14">#{label}</text>
        <text x="#{label_width + (value_width / 2)}" y="14">#{value}</text>
      </g>
    </svg>
  SVG
end

main
