require 'core_ext'
require 'address_match'
require 'intersection_match'
require 'block_match'
require 'null_match'
require 'coordinate'
require 'pg'
require 'sequel'
require 'awesome_print'

DB = Sequel.connect(ENV['DB'] || 'postgres://localhost/kmarsh')

# Attempts to extract a location from semi-free form string
class AddressExtractor
  STREET_SUFFIXES = /st|ave|rd|ct|dr|hwy|blvd|ln|pl/

  def initialize(string)
    @string = string
  end

  def extract
    if @string.match(/(\d+) block ([A-z ]+?) (#{STREET_SUFFIXES})/i)
      return BlockMatch.new($1, "#{$2} #{$3}")
    elsif @string.match(/(\d+) ([A-z ]+?) (#{STREET_SUFFIXES})/i)
      return AddressMatch.new($1, "#{$2} #{$3}")
    elsif @string.match(/([A-z ]+?) (#{STREET_SUFFIXES}) at|and|near ([A-z ]+?)( #{STREET_SUFFIXES})?/i)
      return IntersectionMatch.new("#{$1} #{$2}", "#{$3}#{$4}")
    else
      return NullMatch.new
    end
  end
end
