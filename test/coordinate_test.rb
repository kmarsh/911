$: << "../lib"
require "minitest/autorun"
require "address_extractor"

class TestAddressMatch < Minitest::Test
  def test_distance_to_with_small_distances
    starr_and_sheldon = Coordinate.new(-83.500316, 41.643731)
    starr_and_dearborn = Coordinate.new(-83.501809, 41.643709)

    # Manually verified via http://itouchmap.com/?p=sheldon+and+starr+toledo+ohio&submit=Show+Map&t=l&r=measuredistance
    assert_in_delta 0.125, starr_and_sheldon.distance_to(starr_and_dearborn) # km
    assert_in_delta 0.078, starr_and_sheldon.distance_to(starr_and_dearborn, :mi)
    assert_in_delta 410,   starr_and_sheldon.distance_to(starr_and_dearborn, :ft), 10.0
    assert_in_delta 125.0, starr_and_sheldon.distance_to(starr_and_dearborn, :m), 1.0

    old_house = Coordinate.new(-83.500686, 41.644590)
    new_house = Coordinate.new(-83.583029, 41.703493)
  end
end