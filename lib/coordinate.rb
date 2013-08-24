class Coordinate
  attr_accessor :longitude, :latitude

  def initialize(longitude, latitude)
    @longitude = longitude
    @latitude = latitude
  end

  def to_s
    "#{longitude}, #{latitude}"
  end

  def self.from_wkt(string)
    raise ArgumentError.new("`#{string}` not in POINT WKT format") unless string.match(/^POINT\(([-\d.]+) ([-\d.]+)\)$/)
    new($1.to_f, $2.to_f)
  end

  # This uses the 'haversine' formula to calculate the great-circle distance
  # between two points-that is, the shortest distance over the earth’s surface
  # giving an 'as-the-crow-flies' distance between the points.
  #
  # Haversine formula:
  # a = sin²(Δφ/2) + cos(φ1).cos(φ2).sin²(Δλ/2)
  # c = 2.atan2(√a, √(1−a))
  # d = R.c
  #   where φ is latitude, λ is longitude, R is earth's radius (mean radius = 6,371km)
  #   note that angles need to be in radians to pass to trig functions!
  # (from http://www.movable-type.co.uk/scripts/latlong.html)
  def distance_to(coordinate, unit = :km)
    r = {:km => 6371, :mi => 3956, :ft => 3956 * 5282, :m => 6371 * 1000}

    dLat = deg2rad(coordinate.latitude - self.latitude)
    dLon = deg2rad(coordinate.longitude - self.longitude)

    lat1 = deg2rad(self.latitude)
    lat2 = deg2rad(coordinate.latitude)

    a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    d = r[unit] * c
  end

  private

  def deg2rad(deg)
    (deg * Math::PI / 180)
  end
end