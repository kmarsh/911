require "minitest/autorun"

class TestAddressExtractor < Minitest::Test
  def test_with_address
    assert_equal AddressMatch.new("4945", "dorr st"), AddressExtractor.new("TPD - loud music complaint, mulvaney's at 4945 dorr st").extract
    assert_equal AddressMatch.new("629", "locust st"), AddressExtractor.new("TFD - engine 3 also enroute to the 629 locust st, vistula heritage, report of a person injured in a fourth floor apt").extract
    assert_equal AddressMatch.new("324", "s detroit ave"), AddressExtractor.new("TFD - injuries from an assault, 324 s detroit ave, assist police on scene, engine 21's company").extract
  end

  def test_with_block
    assert_equal BlockMatch.new("2300", "glenwood ave"), AddressExtractor.new("TPD - hit and run injury accident, 2300 block glenwood ave").extract
    assert_equal BlockMatch.new("2800", "stickney ave"), AddressExtractor.new("TFD - injuries from a fight, 2800 block stickney ave, engine 19's company, assist police on scene").extract
    assert_equal BlockMatch.new("300", "dennis ct"), AddressExtractor.new("TPD - fight, 300 block dennis ct, one caller reports 100 teenagers behind the playground fighting").extract
    assert_equal BlockMatch.new("1200", "collingwood blvd"), AddressExtractor.new("TPD - fight, 1200 block collingwood blvd, black and white male fighting").extract
    assert_equal BlockMatch.new("2700", "kenwood blvd"), AddressExtractor.new("2700 block kenwood blvd, noise complaint behind the apartments, loud music and group of people").extract
    assert_equal BlockMatch.new("1300", "w woodruff ave"), AddressExtractor.new("menacing, 1300 block w woodruff ave, male juvs were arguing earlier, now parents over and want the males to fight").extract
  end

  def test_with_intersection
    assert_equal IntersectionMatch.new("arch st", "hayden st"), AddressExtractor.new("TPD/TFD - injuries from an assault, arch st and hayden st").extract
    assert_equal IntersectionMatch.new("hill ave", "wenz"), AddressExtractor.new("#ScannerOn -TPD - multiple callers reporting gunshots heard in the area, hill ave and wenz").extract
    assert_equal IntersectionMatch.new("country creek ln", "wenz rd"), AddressExtractor.new("TPD - crew had group that fired shots, country creek ln and wenz rd, running south towards airport hwy, crews requested code 3").extract
    # assert_equal IntersectionMatch.new("", ""), AddressExtractor.new("")
    assert_equal IntersectionMatch.new("airport hwy", "s holland sylvania rd"), AddressExtractor.new("TPD - 8 sector crews to a code 3 injury accident, airport hwy and s holland sylvania rd, reported car into a pole").extract
  end

  def test_null_match
    assert_kind_of NullMatch, AddressExtractor.new("").extract
    assert_kind_of NullMatch, AddressExtractor.new("dkljf dklsfj sdkl fjdslkf").extract
    assert_kind_of NullMatch, AddressExtractor.new("RT #foobar").extract
  end
end