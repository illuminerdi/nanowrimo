#! /usr/bin/env ruby -w

module Nanowrimo
  class Region
    FIELDS = %w[rid rname region_wordcount max min stddev average count donations numdonors]
    HISTORY_FIELDS = %w[wc wcdate max min stddev average count donations donors]
    attr_accessor(*FIELDS)
    attr_accessor :history
    def initialize(rid)
      @rid = rid
    end
    
    def load
      attribs = Nanowrimo.parse('wcregion', @rid, FIELDS).first
      FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
      end
    end
    
    def load_history
      @history = Nanowrimo.parse('wcregionhist/wordcounts/wcentry',@rid,HISTORY_FIELDS)
    end
  end
end