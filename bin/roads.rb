#!/usr/bin/env ruby
$: << "./lib"
require 'csv'
require 'address_extractor'
require 'pp'

road_words = []

DB["SELECT fullname FROM roads GROUP BY fullname"].each do |row|
  road_words << row[:fullname].downcase.split(" ")
  # puts row[:fullname]
end

road_words = road_words.flatten.uniq.sort - %w[a the and of]

CSV.open("data/extracted-#{Time.now.to_i}.csv", "wb") do |csv|
  CSV.parse(ARGF, headers: true) do |row|
    text = row['text']
    next if text.match(/^@|RT|Toledo Scanner Daily/)

    words = text.downcase.split(" ")
    intersection = words & road_words

    csv << [text, intersection]
  end
end
