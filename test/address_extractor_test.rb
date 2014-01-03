$: << "../lib"
require "minitest/autorun"
require "address_extractor"

class TestAddressExtractor < Minitest::Test
  def test_with_address
    assert_equal AddressMatch.new("4945", "dorr st"), AddressExtractor.new("TPD - loud music complaint, mulvaney's at 4945 dorr st").extract
    assert_equal AddressMatch.new("629", "locust st"), AddressExtractor.new("TFD - engine 3 also enroute to the 629 locust st, vistula heritage, report of a person injured in a fourth floor apt").extract
    assert_equal AddressMatch.new("324", "s detroit ave"), AddressExtractor.new("TFD - injuries from an assault, 324 s detroit ave, assist police on scene, engine 21's company").extract
    assert_equal AddressMatch.new("3730", "monroe st"), AddressExtractor.new("TPD/TFD - injuries from an assault, 3730 monroe st at the stop & go, with engine 17's company").extract
    assert_equal AddressMatch.new("240", "1st st"), AddressExtractor.new("TPD - disorder at tenyeck towers, 240 1st st, people arguing, one said they had a gun").extract
    assert_equal AddressMatch.new("240", "2nd st"), AddressExtractor.new("TPD - disorder at tenyeck towers, 240 2nd st, people arguing, one said they had a gun").extract
    assert_equal AddressMatch.new("240", "3rd st"), AddressExtractor.new("TPD - disorder at tenyeck towers, 240 3rd st, people arguing, one said they had a gun").extract
    assert_equal AddressMatch.new("240", "4th st"), AddressExtractor.new("TPD - disorder at tenyeck towers, 240 4th st, people arguing, one said they had a gun").extract
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
    assert_equal IntersectionMatch.new("airport hwy", "s holland sylvania rd"), AddressExtractor.new("TPD - 8 sector crews to a code 3 injury accident, airport hwy and s holland sylvania rd, reported car into a pole").extract
    assert_equal IntersectionMatch.new("n detroit ave", "palmwood ave"), AddressExtractor.new("TPD - crews at n detroit ave and palmwood ave not finding anybody shot on that corner, other crews slowing down").extract
    assert_equal IntersectionMatch.new("e manhattan blvd", "lagrange st"), AddressExtractor.new("TPD - attempted robbery, meet the papa johhs pizza driver at e manhattan blvd and lagrange st, driver pepper sprayed two potential robbers").extract
    assert_equal IntersectionMatch.new("kent st", "page st"), AddressExtractor.new("TPD - security reporting group of unwanted males from apartments kent st and page st, heading out towards cherry st").extract
    assert_equal IntersectionMatch.new("water st", "n summit st"), AddressExtractor.new("do see that toledo fire and ems dispatched water rescue for water st and n summit st, owens corning area, sounds like downtown suspect").extract
    assert_equal IntersectionMatch.new("spencer st", "south ave"), AddressExtractor.new("TPD - a few gang unit crews out on a suspect stop at spencer st and south ave").extract
    assert_equal IntersectionMatch.new("birmingham terrace", "consaul st"), AddressExtractor.new("TPD - disorder, birmingham terrace near consaul st, report of 5-6 people arguing").extract
  end

  def test_null_match
    assert_kind_of NullMatch, AddressExtractor.new("").extract
    assert_kind_of NullMatch, AddressExtractor.new("dkljf dklsfj sdkl fjdslkf").extract
    assert_kind_of NullMatch, AddressExtractor.new("RT #foobar").extract
  end
end
