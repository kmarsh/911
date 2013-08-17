require "minitest/autorun"
require "./address_extractor"
require "./block_match"
require "./intersection_match"
require "./address_match"

class TestAddressExtractor < Minitest::Test
  def test_with_address
    assert_equal AddressMatch.new("4945", "dorr st"), AddressExtractor.new("TPD - loud music complaint, mulvaney's at 4945 dorr st").extract
  end

  def test_with_block
    assert_equal BlockMatch.new("2300", "glenwood ave"), AddressExtractor.new("TPD - hit and run injury accident, 2300 block glenwood ave").extract
  end

  def test_with_interesection
    assert_equal IntersectionMatch.new("arch st", "hayden st"), AddressExtractor.new("TPD/TFD - injuries from an assault, arch st and hayden st").extract
  end
end