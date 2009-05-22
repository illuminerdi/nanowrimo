#! /usr/bin/env ruby -w

module Nanowrimo
  class Site
    FIELDS = %w[site_wordcount max min stddev average count]
    HISTORY_FIELDS = %w[wc wcdate max min stddev average count]
    attr_accessor(*FIELDS)
    attr_accessor :history
    def load
      attribs = Nanowrimo.parse('wcstatssummary', nil, FIELDS).first
      FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
      end
    end
    
    def load_history
      @history = Nanowrimo.parse('wcstats/wordcounts/wcentry', nil, HISTORY_FIELDS)
    end
  end
end