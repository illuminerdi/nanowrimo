#! /usr/bin/env ruby -w

module Nanowrimo
  class Genre < Core
    FIELDS = %w[gid gname genre_wordcount max min stddev average count]
    HISTORY_FIELDS = %w[wc wcdate max min stddev average count]
    attr_accessor(*FIELDS)
    attr_accessor :history
    def initialize(gid)
      @gid = gid
    end
    
    def id
      @gid
    end
    
    def load_field
      'wcgenre'
    end
    
    def load_history_field
      'wcgenrehist/wordcounts/wcentry'
    end
  end
end