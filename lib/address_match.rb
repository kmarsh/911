class AddressMatch < Struct.new(:number, :street)
  def to_s
    "Address: #{number} #{street}"
  end

  def geocode
    # Performed in multiple steps:
    #   1. Get matching road segment that contains the address
    #   2. Determine position of address in range for that segment (from 0 - 1)
    #   3. Query road segment geometry for point closest to that position

    rows = DB["SELECT tlid, lfromadd, ltoadd, rfromadd, rtoadd FROM roads WHERE fullname ILIKE ? AND (? BETWEEN lfromadd AND ltoadd OR ? BETWEEN rfromadd AND rtoadd)", street, number, number]

    return nil unless rows.count == 1

    row = rows.first

    tlid = row[:tlid]

    l_percentage = Range.new(row[:lfromadd].to_i, row[:ltoadd].to_i).interpolate(number)
    r_percentage = Range.new(row[:rfromadd].to_i, row[:rtoadd].to_i).interpolate(number)

    if row[:lfromadd].to_i.even? && number.to_i.even?
      percentage = l_percentage
    elsif row[:rfromadd].to_i.even? && number.to_i.even?
      percentage = r_percentage
    elsif row[:lfromadd].to_i.odd? && number.to_i.odd?
      percentage = l_percentage
    elsif row[:rfromadd].to_i.odd && number.to_i.odd?
      percentage = r_percentage
    end

    rows = DB["SELECT ST_AsEWKT(ST_Line_Interpolate_Point(geom, ?)) AS geom FROM roads WHERE tlid = ?", percentage, tlid]

    return nil unless rows.count == 1

    Coordinate.from_wkt(rows.first[:geom])
  end

end