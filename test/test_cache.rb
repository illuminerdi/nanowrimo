#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'

class TestCache < Test::Unit::TestCase
  def test_cache_data_exists
    assert Nanowrimo::Cache.cache_data
    assert Nanowrimo::Cache.cache_data.instance_of?(Hash)
  end

  def test_write_cache_to_disk
    File.delete(Nanowrimo::Cache::CACHE_FILE) if File.exist?(Nanowrimo::Cache::CACHE_FILE)
    Nanowrimo::Cache.save_cache_to_disk
    assert File.exist?(Nanowrimo::Cache::CACHE_FILE)
  end

  def test_add_to_cache
    type="foo"
    key="bar"
    data = [{:uid => "240659", :uname => "hollowedout"}]
    Nanowrimo::Cache.add_to_cache(type, key, data)
    assert_equal data, Nanowrimo::Cache.cache_data[type][key][:data]
  end

  def test_find_data_returns_cached_data
    type="foo"
    key="bar"
    data = [{:uid => "12345", :uname => "foo", :user_wordcount => "123456"}]
    Nanowrimo::Cache.add_to_cache(type, key, data)
    actual = Nanowrimo::Cache.find_data(type, key)
    assert actual
    assert "12345", actual.first[:uid]
  end

  def test_find_data_finds_nothing_for_type
    type="bar"
    key="foo"
    actual = Nanowrimo::Cache.find_data(type, key)
    assert actual.nil?
  end

  def test_find_data_finds_nothing_for_key
    type="foo2"
    key="bar2"
    actual = Nanowrimo::Cache.find_data(type,key)
    assert actual.nil?
  end

  def test_clear_cache_clears_cache
    assert Nanowrimo::Cache.find_data("foo","bar")
    Nanowrimo::Cache.clear_cache
    assert Nanowrimo::Cache.cache_data.empty?
  end
end