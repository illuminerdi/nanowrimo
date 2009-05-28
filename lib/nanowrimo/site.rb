#! /usr/bin/env ruby -w

module Nanowrimo
  class Site < Core
    FIELDS = %w[site_wordcount max min stddev average count]
    HISTORY_FIELDS = %w[wc wcdate max min stddev average count]
    attr_accessor(*FIELDS)
    attr_accessor :history
    def id
      nil
    end
    
    def load_field
      'wcstatssummary'
    end
    
    def load_history_field
      'wcstats/wordcounts/wcentry'
    end
  end
end