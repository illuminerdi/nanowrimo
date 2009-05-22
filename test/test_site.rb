#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'
require 'fakeweb'

class TestSite < Test::Unit::TestCase
  def setup
    @site = Nanowrimo::Site.new
  end

  def test_site_has_appropriate_fields
    expected = %w[site_wordcount max min stddev average count]
    assert_equal expected, Nanowrimo::Site::FIELDS
  end

  def test_site_has_appropriate_history_fields
    expected = %w[wc wcdate max min stddev average count]
    assert_equal expected, Nanowrimo::Site::HISTORY_FIELDS
  end

  def test_site_loads_data
    file = 'test/fixtures/site_wc.xml'
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wcstatssummary", :file => file)
    @site.load
    Nanowrimo::Site::FIELDS.each do |f|
      assert @site.send(:"#{f}")
    end
  end

  def test_site_loads_historical_data
    file = 'test/fixtures/site_wc_history.xml'
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wcstats", :file => file)
    @site.load_history
    assert @site.history
    assert_equal 30, @site.history.size
    assert_equal 7, @site.history.first.keys.size
  end
end