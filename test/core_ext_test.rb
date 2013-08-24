$: << "../lib"
require "minitest/autorun"
require "address_extractor"

class TestCoreExt < Minitest::Test
  def test_range_interpolate
    assert_equal 0.0, (0..10).interpolate(0)
    assert_equal 0.5, (0..10).interpolate(5)
    assert_equal 1.0, (0..10).interpolate(10)
  end

  def test_range_interpolate_with_outliers
    assert_equal 0.0, (0..100).interpolate(-100)

    assert_equal 0.0,  (0..100).interpolate(0)
    assert_equal 0.25, (0..100).interpolate(25)
    assert_equal 0.5,  (0..100).interpolate(50)
    assert_equal 0.75, (0..100).interpolate(75)
    assert_equal 1.0,  (0..100).interpolate(100)

    assert_equal 1.0, (0..100).interpolate(500)
  end
end