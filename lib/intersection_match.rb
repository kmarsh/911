class IntersectionMatch < Struct.new(:street_1, :street_2)
  def initialize(street_1, street_2)
    @street_1 = street_1.strip
    @street_2 = street_2.strip
  end

  def to_s
    "Intersection: #{@street_1} & #{@street_2}"
  end

  def geocode
    rows = DB["SELECT r1.fullname AS road1, r2.fullname AS road2, ST_AsText(ST_Intersection(r1.geom, r2.geom)) as intersection FROM roads r1 CROSS JOIN roads r2 WHERE r1.fullname ILIKE ? AND r2.fullname ILIKE ? AND ST_GeometryType(ST_Intersection(r1.geom, r2.geom)) = 'ST_Point' GROUP BY r1.fullname, r2.fullname, intersection ORDER BY road1, road2", "#{@street_1}%", "#{@street_2}%"]

    if rows.count == 1
      Coordinate.from_wkt(rows.first[:intersection])
    else
      nil
    end
  end
end