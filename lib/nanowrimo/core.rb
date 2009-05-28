#! /usr/bin/env ruby -w

module Nanowrimo
  class Core
    def load
      attribs = Nanowrimo.parse(load_field,id,self.class::FIELDS).first
      self.class::FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
      end
    end
    
    def load_history
      self.history = Nanowrimo.parse(load_history_field,id,self.class::HISTORY_FIELDS)
    end
  end
end