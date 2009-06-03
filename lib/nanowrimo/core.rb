#! /usr/bin/env ruby -w

module Nanowrimo
  # Core load methods
  class Core
    # attribute for storing error message returned by WCAPI on any response.
    attr_accessor :error
    
    # Returns the values for all attributes for a given WCAPI type
    def load
      attribs = Nanowrimo.parse(load_field,id,self.class::FIELDS).first
      self.class::FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
        self.error = attribs[:error]
      end
    end

    # Returns the values for all attributes for a given WCAPI type's history
    def load_history
      self.history = Nanowrimo.parse(load_history_field,id,self.class::HISTORY_FIELDS)
      if maybe_error = self.history.first
        self.error = maybe_error[:error]
      end
    end
    
    # Tells us if the current object has any errors from the WCAPI
    def has_error?
      !error.nil?
    end
  end
end