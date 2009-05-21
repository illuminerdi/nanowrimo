#! /usr/bin/env ruby -w

$: << 'lib'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'nanowrimo/user'

module Nanowrimo
  VERSION = '0.1'
  API_URI = 'http://www.nanowrimo.org/wordcount_api'
  
  def self.parse(type, key, params)
    file = "#{API_URI}/#{type}/#{key}"
    doc = Nokogiri::XML(open(file))
    result = {}
    doc.xpath(type).each {|n|
      params.each {|d|
        result[d.intern] = n.at(d).content
      }
    }
    result
  end
  
  def self.parse_history(type, key, params)
    file = "#{API_URI}/#{type}/#{key}"
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