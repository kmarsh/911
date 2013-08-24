$: << "../lib"
require "minitest/autorun"
require "address_extractor"

class TestIntersectionMatch < Minitest::Test
  def test_geocode
    coordinate = IntersectionMatch.new("starr ave", "sheldon st").geocode
    assert_kind_of Coordinate, coordinate
    google_maps_coordinate = Coordinate.new(-83.500316, 41.643731)

    # Assert calculated is within 10 meters of Google Maps-verified coordinate
    assert_includes 0..10, coordinate.distance_to(google_maps_coordinate, :m)
  end
end