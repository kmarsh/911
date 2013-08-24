#!/usr/bin/env ruby
$: << "./lib"
require 'csv'
require 'address_extractor'

CSV.open("data/extracted-#{Time.now.to_i}.csv", "wb") do |csv|
  CSV.parse(ARGF, headers: true) do |row|
    next if row['text'].match(/^@|RT|Toledo Scanner Daily/)

    address_extractor = AddressExtractor.new(row['text'])
    match = address_extractor.extract

    csv << [row['text'], match.class, match, match.geocode]
  end
end