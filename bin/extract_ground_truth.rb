#!/usr/bin/env ruby
$: << "./lib"
require 'csv'
require 'address_extractor'

total_lines = 0
valid_lines = 0
match_classes = Hash.new(0)

CSV.open("data/extracted-#{Time.now.to_i}.csv", "wb") do |csv|
  CSV.parse(ARGF, headers: true) do |row|
    total_lines += 1

    next if row['text'].match(/^@|RT|Toledo Scanner Daily/)
    valid_lines += 1

    address_extractor = AddressExtractor.new(row['text'])
    match = address_extractor.extract
    match_classes[match.class] += 1

    csv << [row['text'], match.class, match]
  end
end

total_matches = match_classes.reject {|k, v| k == NullMatch }.values.reduce(:+)

STDERR.puts "Total Lines: %d" % [total_lines]
STDERR.puts "Valid Lines: %d (%0.2f%%)" % [valid_lines, (valid_lines.to_f / total_lines.to_f) * 100.0]
STDERR.puts "Total Matches: %d (%0.2f%%)" % [total_matches, (total_matches.to_f / valid_lines.to_f) * 100.0]

match_classes.each do |k, v|
  STDERR.puts "  #{k} Matches: %d (%0.2f%%)" % [v, (v.to_f/valid_lines.to_f) * 100.0]
end
