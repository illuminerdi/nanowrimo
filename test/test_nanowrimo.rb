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
    file = "test/user_wc.xml"
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/#{type}/#{key}", :file => file)
    actual = Nanowrimo.parse(type, key, params)
    expected = {
      :uid => "240659",
      :uname => "hollowedout",
      :user_wordcount => "55415"
    }
    assert_equal expected, actual
  end
end