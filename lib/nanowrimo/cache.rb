#! /usr/bin/env ruby -w

require 'thread'
require 'yaml'

module Nanowrimo
  class Cache
    @@cache_data = {}
    @cache_mutex = Mutex.new
    def self.cache_data
      @@cache_data
    end
    
    def self.load_cache
      if File.exist?(Nanowrimo::CACHE_FILE)
        @@cache_data = YAML::load(File.read(Nanowrimo::CACHE_FILE))
      end
    end
    
    def self.save_cache_to_disk
      File.open(Nanowrimo::CACHE_FILE, 'w') do |out|
        YAML.dump(@@cache_data, out)
      end
    end
    
    def self.add_to_cache type, key, data=[]
      @cache_mutex.synchronize{
        @@cache_data["#{type}"] = {"#{key}" => Hash[:data, data, :created_at, Time.now]}
      }
    end
  end
end