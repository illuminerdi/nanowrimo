#! /usr/bin/env ruby -w

$: << 'lib'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'nanowrimo/user'
require 'nanowrimo/site'
require 'nanowrimo/region'
require 'nanowrimo/genre'

module Nanowrimo
  VERSION = '0.1'
  API_URI = 'http://www.nanowrimo.org/wordcount_api'
  GOAL = 50_000

  def self.parse(path, key, attribs)
    method = path.split('/').first
    uri = "#{API_URI}/#{method}"
    uri = "#{uri}/#{key}" unless key.nil?
    doc = Nokogiri::XML(open(uri))
    result = []
    doc.xpath(path).each {|n|
      node = {}
      attribs.each {|d|
        node[d.intern] = n.at(d).content
      }
      result << node
    }
    result
  end
end