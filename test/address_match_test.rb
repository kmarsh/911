$: << "../lib"
require "minitest/autorun"
require "address_extractor"

class TestAddressMatch < Minitest::Test
  def test_geocode
    # puts AddressMatch.new("1619", "Slater St").geocode.inspect
    # puts AddressMatch.new("350", "Sheldon St").geocode.inspect
  end
end