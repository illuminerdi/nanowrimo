#! /usr/bin/env ruby -w

$: << 'lib'
require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'nanowrimo/user'
require 'nanowrimo/site'
require 'nanowrimo/region'
require 'nanowrimo/genre'
require 'nanowrimo/cache'

module Nanowrimo
  VERSION = '0.6'
  API_URI = 'http://www.nanowrimo.org/wordcount_api'
  GOAL = 50_000
  Nanowrimo::Cache.load_cache if Nanowrimo::Cache.cache_data == {}

  def self.parse(path, key, attribs)
    result = data_from_cache(path, key, attribs) ||
      data_from_internets(path, key, attribs)
  end
  
  def self.data_from_cache(path, key, attribs)
    Nanowrimo::Cache.cache_mutex.synchronize {
      type = path.split('/').first
      return nil unless Nanowrimo::Cache.cache_data["#{type}"]
      return nil unless Nanowrimo::Cache.cache_data["#{type}"]["#{key}"]
      Nanowrimo::Cache.cache_data["#{type}"]["#{key}"][:data]
    }
  end
  
  def self.data_from_internets(path, key, attribs)
    method = path.split('/').first
    uri = "#{API_URI}/#{method}"
    uri = "#{uri}/#{key}" unless key.nil?
    result = []
    doc = Nokogiri::XML(open(uri))
    doc.xpath(path).each {|n|
      node = {}
      attribs.each {|d|
        node[d.intern] = n.at(d).content
      }
      result << node
    }
    key = method if key.nil? # kinda hackish, but for the site stats
    Nanowrimo::Cache.add_to_cache("#{method}","#{key}",result)
    result
  end
  
  at_exit {
    Nanowrimo::Cache.save_cache_to_disk
  }
end