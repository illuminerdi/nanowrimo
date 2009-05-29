#! /usr/bin/env ruby -w

require 'thread'
require 'yaml'

module Nanowrimo
  # Handles caching of WCAPI data
  class Cache
    CACHE_FILE = './nano_cache'
    # 24 hours in seconds, defines when cached data expires.
    DEFAULT_MAX_CACHE_AGE = (24*60*60)
    @@cache_data = {}
    @@cache_mutex = Mutex.new
    def self.cache_data
      @@cache_data
    end
    def self.cache_mutex
      @@cache_mutex
    end

    # Load the cached data into memory from disk.
    def self.load_cache
      if File.exist?(CACHE_FILE)
        @@cache_data = YAML::load(File.read(CACHE_FILE))
      end
    end

    # For when the cache needs to be not in memory anymore.
    def self.save_cache_to_disk
      File.open(CACHE_FILE, 'w') do |out|
        YAML.dump(@@cache_data, out)
      end
    end

    # Receives data that needs to be added to the cache
    def self.add_to_cache type, key, data=[]
      @@cache_mutex.synchronize{
        @@cache_data["#{type}"] = {"#{key}" => Hash[:data, data, :created_at, Time.now]}
      }
    end
  end
end