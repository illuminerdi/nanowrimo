#! /usr/bin/env ruby -w

# Nanowrimo is an API Wrapper for the Nanowrimo.org WCAPI.
# In its current implementation it manages all data brought down from the WCAPI.
#
# Author:: Joshua Clingenpeel (joshua.clingenpeel@gmail.com)
# Copyright:: Copyright (c) 2009 Joshua Clingenpeel
# License:: MIT License

require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'nanowrimo/core'
require 'nanowrimo/user'
require 'nanowrimo/site'
require 'nanowrimo/region'
require 'nanowrimo/genre'
require 'nanowrimo/cache'

# This module handles caching, a few constants, and the all-important XML parsing method
# for both current data and historical data from the WCAPI. It should be generic enough to
# never have to be touched again, but keep your fingers crossed anyway.

module Nanowrimo
  # Current API version
  VERSION = '0.8.0'
  # Current static root WCAPI uri
  API_URI = 'http://www.nanowrimo.org/wordcount_api'
  # Current individual user word count goal. For fun!
  GOAL = 50_000
  Nanowrimo::Cache.load_cache if Nanowrimo::Cache.cache_data == {}

  # Pull requested data from cache or from the WCAPI
  def self.parse(path, key, attribs, options={:force => false})
    result = options[:force] == true ? data_from_internets(path, key, attribs) : data_from_cache(path, key) ||
      data_from_internets(path, key, attribs)
  end

  # Finds the data in the cache and returns it, or nil, taking into account age of cache data.
  def self.data_from_cache(path, key)
    type = path.split('/').first
    Nanowrimo::Cache.find_data(type, key)
  end

  # Parses XML from the WCAPI and returns an array of hashes with the data. Caches it, too.
  def self.data_from_internets(path, key, attribs)
    type = path.split('/').first
    uri = "#{API_URI}/#{type}"
    uri = "#{uri}/#{key}" unless key.nil?
    result = []
    begin
      timeout(2) {
        doc = Nokogiri::XML(open(uri))
        doc.xpath("#{type}/error").each {|e|
          result << {:error => e.content}
        }
        return result unless result.empty?
        doc.xpath(path).each {|n|
          node = {}
          attribs.each {|d|
            node[d.intern] = n.at(d).content unless n.at(d).nil?
          }
          result << node
        }
      }
    rescue Timeout::Error
      throw NanowrimoError, "Timed out attempting to connect to Nanowrimo.org"
    end
    key ||= type # kinda hackish, but for the site stats it's needed
    Nanowrimo::Cache.add_to_cache("#{type}","#{key}",result)
    result
  end

  at_exit {
    Nanowrimo::Cache.save_cache_to_disk
  }
end

# Generic error class
class NanowrimoError < StandardError; end