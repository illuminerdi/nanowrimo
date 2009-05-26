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
end