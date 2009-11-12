#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'
require 'fakeweb'

class TestNanowrimo < Test::Unit::TestCase
  # the purpose for this test class is to make sure that Nanowrimo has a method to
  # open an xml document and parse it given a set of fields and a search string.
  # It's going to be a loose wrapper around Nokogiri which should keep the api DRY.

  def setup
    FakeWeb.allow_net_connect = false
    FakeWeb.clean_registry
  end

  def test_nanowrimo_has_parse_method
    assert Nanowrimo.respond_to?(:parse)
  end

  def test_nanowrimo_has_data_loading_methods
    assert Nanowrimo.respond_to?(:data_from_cache)
    assert Nanowrimo.respond_to?(:data_from_internets)
  end

  def test_nanowrimo_data_load_from_internets_returns_hash_with_data
    attribs = %w[uid uname user_wordcount]
    path = "wc"
    key = 240659
    file = "test/fixtures/user_wc.xml"
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wc/#{key}", :body => file)
    actual = Nanowrimo.data_from_internets(path, key, attribs).first
    expected = {
      :uid => "240659",
      :uname => "hollowedout",
      :user_wordcount => "55415"
    }
    assert_equal expected, actual
  end

  def test_nanowrimo_parse_does_the_same_as_data_from_internets
    attribs = %w[uid uname user_wordcount]
    path = "wc"
    key = 240659
    file = "test/fixtures/user_wc.xml"
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wc/#{key}", :body => file)
    actual = Nanowrimo.parse(path, key, attribs).first
    expected = {
      :uid => "240659",
      :uname => "hollowedout",
      :user_wordcount => "55415"
    }
    assert_equal expected, actual
  end

  def test_nanowrimo_data_from_cache_returns_hash_with_data
    attribs = %w[uid uname user_wordcount]
    path = "wc"
    key = 240659
    file = "test/fixtures/user_wc.xml"
    File.delete(Nanowrimo::Cache::CACHE_FILE) if File.exist?(Nanowrimo::Cache::CACHE_FILE)
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wc/#{key}", :body => file)
    Nanowrimo.data_from_internets(path, key, attribs)
    FakeWeb.clean_registry
    actual = Nanowrimo.data_from_cache(path, key).first
    expected = {
      :uid => "240659",
      :uname => "hollowedout",
      :user_wordcount => "55415"
    }
    assert_equal expected, actual
  end

  def test_nanowrimo_parse_uses_cache_after_loading_from_internets_the_first_time
    attribs = %w[uid uname user_wordcount]
    path = "wc"
    key = 240659
    file = "test/fixtures/user_wc.xml"
    File.delete(Nanowrimo::Cache::CACHE_FILE) if File.exist?(Nanowrimo::Cache::CACHE_FILE)
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wc/#{key}", :body => file)
    Nanowrimo.parse(path, key, attribs)
    FakeWeb.clean_registry
    actual = {}
    assert_nothing_raised do
      actual = Nanowrimo.parse(path, key, attribs).first
    end
    expected = {
      :uid => "240659",
      :uname => "hollowedout",
      :user_wordcount => "55415"
    }
    assert_equal expected, actual
  end

  def test_nanowrimo_parse_history_returns_array_of_hashes_with_data
    attribs = %w[wc wcdate]
    path = "wchistory/wordcounts/wcentry"
    key = 240659
    file = "test/fixtures/user_wc_history.xml"
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wchistory/#{key}", :body => file)
    data = Nanowrimo.parse(path, key, attribs)
    assert_equal 30, data.size
    data.each do |d|
      assert_equal 2, d.keys.size
    end
    expected = {:wc => "0", :wcdate => "2008-11-01"}
    assert_equal expected, data.first
  end

  def test_nanowrimo_parse_handles_wcapi_error_message
    attribs = %w[uid uname user_wordcount]
    path = "wc"
    key = 999999
    file = "test/fixtures/user_wc_error.xml"
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wc/#{key}", :body => file)
    actual = Nanowrimo.data_from_internets(path, key, attribs).first
    expected = {
      :error => "user not found or is inactive"
    }
    assert_equal expected, actual
  end

  def test_nanowrimo_parse_handles_forced_internet_data
    attribs = %w[uid uname user_wordcount]
    path = "wc"
    key = 999999
    file = "test/fixtures/user_wc_error.xml"
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wc/#{key}", :body => file)
    data = Nanowrimo.parse(path, key, attribs)
    FakeWeb.clean_registry
    assert_raise FakeWeb::NetConnectNotAllowedError do
      Nanowrimo.parse(path, key, attribs, {:force => true})
    end
  end
end