#! /usr/bin/env ruby -w

module Nanowrimo
  class User
    FIELDS = %w[uid uname user_wordcount]
    HISTORY_FIELDS = %w[]
    attr_accessor(*FIELDS)
    def initialize uid
      @uid = uid
    end
    
    def load
      attribs = Nanowrimo.parse('wc', @uid, FIELDS)
      FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
      end
    end
  end
end