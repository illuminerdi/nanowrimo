#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'
require 'fakeweb'

class TestNanowrimo < Test::Unit::TestCase
  # the purpose for this test class is to make sure that Nanowrimo has a method to 
  # open an xml document and parse it given a set of fields and a search string.
  # It's going to be a loose wrapper around Nokogiri which should keep the api DRY.
  
  def test_nanowrimo_has_parse_method
    assert Nanowrimo.respond_to?(:parse)
  end
  
  def test_nanowrimo_parse_returns_hash_with_data
    params = %w[uid uname user_wordcount]
    type = "wc"
    key = 240659
    file = "test/fixtures/user_wc.xml"
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/#{type}/#{key}", :file => file)
    actual = Nanowrimo.parse(type, key, params).first
    expected = {
      :uid => "240659",
      :uname => "hollowedout",
      :user_wordcount => "55415"
    }
    assert_equal expected, actual
  end
  
  def test_nanowrimo_parse_history_returns_array_of_hashes_with_data
    params = %w[wc wcdate]
    type = "wchistory/wordcounts/wcentry"
    key = 240659
    file = "test/fixtures/user_wc_history.xml"
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wchistory/#{key}", :file => file)
    data = Nanowrimo.parse(type, key, params)
    assert_equal 30, data.size
    data.each do |d|
      assert_equal 2, d.keys.size
    end
    expected = {:wc => "0", :wcdate => "2008-11-01"}
    assert_equal expected, data.first
  end
end