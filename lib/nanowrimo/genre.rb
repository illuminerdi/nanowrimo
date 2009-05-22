#! /usr/bin/env ruby -w

module Nanowrimo
  class Genre
    FIELDS = %w[gid gname genre_wordcount max min stddev average count]
    HISTORY_FIELDS = %w[wc wcdate max min stddev average count]
    attr_accessor(*FIELDS)
    attr_accessor :history
    def initialize(gid)
      @gid = gid
    end
    
    def load
      attribs = Nanowrimo.parse('wcgenre', @gid, FIELDS).first
      FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
      end
    end
    
    def load_history
      @history = Nanowrimo.parse('wcgenrehist/wordcounts/wcentry', @gid, HISTORY_FIELDS)
    end
  end
end