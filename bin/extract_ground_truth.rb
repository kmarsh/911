#!/usr/bin/env ruby
require 'csv'
require './address_extractor'

CSV.parse(ARGF, headers: true) do |row|
  next if row['text'].match(/^@|RT|Toledo Scanner Daily/)
  address_extractor = AddressExtractor.new(row['text'])
  puts "%s: %s" % [row['text'], address_extractor.extract]
end