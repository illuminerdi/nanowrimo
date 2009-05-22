#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'
require 'fakeweb'

class TestRegion < Test::Unit::TestCase
  def setup
    @region = Nanowrimo::Region.new("84")
  end
  
  def test_regions_has_appropriate_fields
    expected = %w[rid rname region_wordcount max min stddev average count donations numdonors]
    assert_equal expected, Nanowrimo::Region::FIELDS
  end
  
  def test_regions_has_appropriate_history_fields
    expected = %w[wc wcdate max min stddev average count donations donors]
    assert_equal expected, Nanowrimo::Region::HISTORY_FIELDS
  end
  
  def test_region_loads_current_data
    file = 'test/fixtures/region_wc.xml'
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wcregion/84", :file => file)
    @region.load
    Nanowrimo::Region::FIELDS.each do |f|
      assert @region.send(:"#{f}")
    end
  end
  
  def test_region_loads_historical_data
    file = 'test/fixtures/region_wc_history.xml'
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wcregionhist/84", :file => file)
    @region.load_history
    assert @region.history
    assert_equal 9, @region.history.first.size
    assert_equal 30, @region.history.size
  end
end