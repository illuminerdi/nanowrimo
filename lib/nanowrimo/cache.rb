#! /usr/bin/env ruby -w

require 'thread'
require 'yaml'

module Nanowrimo
  class Cache
    CACHE_FILE = './nano_cache'
    DEFAULT_MAX_CACHE_AGE = (24*60*60) # 24 hours in seconds
    @@cache_data = {}
    @@cache_mutex = Mutex.new
    def self.cache_data
      @@cache_data
    end
    def self.cache_mutex
      @@cache_mutex
    end
    
    def self.load_cache
      if File.exist?(CACHE_FILE)
        @@cache_data = YAML::load(File.read(CACHE_FILE))
      end
    end
    
    def self.save_cache_to_disk
      File.open(CACHE_FILE, 'w') do |out|
        YAML.dump(@@cache_data, out)
      end
    end
    
    def self.add_to_cache type, key, data=[]
      @@cache_mutex.synchronize{
        @@cache_data["#{type}"] = {"#{key}" => Hash[:data, data, :created_at, Time.now]}
      }
    end
  end
end