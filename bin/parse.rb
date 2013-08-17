#!/usr/bin/env ruby
require 'oj'
require 'pp'

h2 = Oj.load(ARGF)
h2['features'].each do |feature|

  # ["STATEFP",
  #  "COUNTYFP",
  #  "TLID",
  #  "TFIDL",
  #  "TFIDR",
  #  "MTFCC",
  #  "FULLNAME",
  #  "SMID",
  #  "LFROMADD",
  #  "LTOADD",

  # puts "#{feature['properties']['FULLNAME']}|#{feature['properties']['RFROMADD']}|#{feature['properties']['RTOADD']}|#{feature['properties']['LFROMADD']}|#{feature['properties']['LTOADD']}|#{feature['geometry']['coordinates']}"
  puts feature['properties']['FULLNAME']
end