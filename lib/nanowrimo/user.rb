#! /usr/bin/env ruby -w

module Nanowrimo
  class User
    FIELDS = %w[uid uname user_wordcount]
    HISTORY_FIELDS = %w[wc wcdate]
    attr_accessor(*FIELDS)
    attr_accessor :history
    def initialize uid
      @uid = uid
    end
    
    def load
      attribs = Nanowrimo.parse('wc', @uid, FIELDS).first
      FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
      end
    end
    
    def load_history
      @history = Nanowrimo.parse('wchistory/wordcounts/wcentry', @uid, HISTORY_FIELDS)
    end
    
    def winner?
      self.user_wordcount.to_i >= Nanowrimo::GOAL
    end
  end
end