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
    if @string.match(/(\d+) block (#{STREET_NAMES}) (#{STREET_SUFFIXES})/i)
      return BlockMatch.new($1, "#{$2} #{$3}")
    elsif @string.match(/(\d+) (#{STREET_NAMES}) (#{STREET_SUFFIXES})/i)
      return AddressMatch.new($1, "#{$2} #{$3}")
    elsif @string.match(/(#{STREET_NAMES}) (#{STREET_SUFFIXES}) at|and|near (#{STREET_NAMES})( #{STREET_SUFFIXES})?/i)
      return IntersectionMatch.new("#{$1} #{$2}", "#{$3}#{$4}")
    else
      return NullMatch.new
    end
  end
end
