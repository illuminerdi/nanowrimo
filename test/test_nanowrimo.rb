#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'

class TestNanowrimo < Test::Unit::TestCase
  # the purpose for this test class is to make sure that Nanowrimo has a method to 
  # open an xml document and parse it given a set of fields and a search string.
  # It's going to be a loose wrapper around Nokogiri which should keep the api DRY.
  
  def test_nanowrimo_has_find_method
    assert Nanowrimo.respond_to?(:find)
  end
end