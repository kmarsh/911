$: << "../lib"
require "minitest/autorun"
require "address_extractor"

class TestAddressMatch < Minitest::Test
  def test_distance_to
    starr_and_sheldon = Coordinate.new(-83.500316, 41.643731)
    starr_and_dearborn = Coordinate.new(-83.501809, 41.643709)

    assert_in_delta 0.1241, starr_and_sheldon.distance_to(starr_and_dearborn)
    assert_in_delta 0.0771, starr_and_sheldon.distance_to(starr_and_dearborn, :mi)
    assert_in_delta 407.152, starr_and_sheldon.distance_to(starr_and_dearborn, :ft), 1.0
    assert_in_delta 124.1, starr_and_sheldon.distance_to(starr_and_dearborn, :m), 1.0
  end
end