#! /usr/bin/env ruby -w

module Nanowrimo
  class Region < Core
    FIELDS = %w[rid rname region_wordcount max min stddev average count donations numdonors]
    HISTORY_FIELDS = %w[wc wcdate max min stddev average count donations donors]
    attr_accessor(*FIELDS)
    attr_accessor :history
    def initialize(rid)
      @rid = rid
    end
    
    def id
      @rid
    end
    
    def load_field
      'wcregion'
    end
    
    def load_history_field
      'wcregionhist/wordcounts/wcentry'
    end
  end
end