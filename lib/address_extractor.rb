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
  STREET_NAMES = /[A-z ]+?|[0-9]+(?:st|nd|rd|th){1}/
  STREET_SUFFIXES = /st|ave|rd|ct|dr|hwy|blvd|ln|pl|pkwy/

  def initialize(string)
    @string = string
  end

  def extract
    case @string
    when /(\d+) block (#{STREET_NAMES}) (#{STREET_SUFFIXES})/i
      BlockMatch.new($1, "#{$2} #{$3}")
    when /(\d+) (#{STREET_NAMES}) (#{STREET_SUFFIXES})/i
      AddressMatch.new($1, "#{$2} #{$3}")
    when /at|, ([A-z ]+?) (#{STREET_SUFFIXES}) (?:at|and|near) ([A-z ]+?) (#{STREET_SUFFIXES})/i
      IntersectionMatch.new("#{$1} #{$2}".strip, "#{$3} #{$4}".strip)
    else
      NullMatch.new
    end
  end
end
