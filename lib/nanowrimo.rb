#! /usr/bin/env ruby -w

$: << 'lib'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'nanowrimo/user'

module Nanowrimo
  VERSION = '0.1'
  API_URI = 'http://www.nanowrimo.org/wordcount_api'
  GOAL = 50_000
  
  def self.parse(type, key, params)
    method = type.split('/').first
    file = "#{API_URI}/#{method}/#{key}"
    doc = Nokogiri::XML(open(file))
    result = []
    doc.xpath(type).each {|n|
      node = {}
      params.each {|d|
        node[d.intern] = n.at(d).content
      }
      result << node
    }
    result
  end
end