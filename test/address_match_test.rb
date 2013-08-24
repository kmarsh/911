$: << "../lib"
require "minitest/autorun"
require "address_extractor"

class TestAddressMatch < Minitest::Test
  def test_geocode_accuracy
    [
      ["1619", "Slater St", -83.583029, 41.703493],
      ["350", "Sheldon St", -83.500686, 41.64459]
    ].each do |row|
      coordinate = AddressMatch.new(row[0], row[1]).geocode
      google_maps_coordinate = Coordinate.new(row[2], row[3])

      assert_includes 0..50, coordinate.distance_to(google_maps_coordinate, :m)
    end
  end
end