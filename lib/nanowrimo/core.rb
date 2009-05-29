#! /usr/bin/env ruby -w

module Nanowrimo
  # Core load methods
  class Core
    # Returns the values for all attributes for a given WCAPI type
    def load
      attribs = Nanowrimo.parse(load_field,id,self.class::FIELDS).first
      self.class::FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
      end
    end

    # Returns the values for all attributes for a given WCAPI type's history    
    def load_history
      self.history = Nanowrimo.parse(load_history_field,id,self.class::HISTORY_FIELDS)
    end
  end
end