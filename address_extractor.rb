# Attempts to extract a location from semi-free form string
class AddressExtractor
  def initialize(string)
    @string = string
  end

  def extract
    if @string.match(/(\d+) (.+) (st)/i)
      return AddressMatch.new($1, "#{$2} #{$3}")
    elsif @string.match(/(\d+) block (.+)/i)
      return BlockMatch.new($1, $2)
    elsif @string.match(/(.+) (st) and (.+) (st)/i)
      return IntersectionMatch.new("#{$1} #{$2}", "#{$3} #{$4}")
    end
  end
end