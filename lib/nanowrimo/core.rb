#! /usr/bin/env ruby -w

module Nanowrimo
  # Core load methods
  class Core
    # attribute for storing error message returned by WCAPI on any response.
    attr_accessor :error

    # Returns the values for all attributes for a given WCAPI type
    #
    # Options:
    #
    # * :force - if set to true, will force Nanowrimo data to be pulled from the WCAPI and ignore cache data. not really recommended for bandwidth reasons.
    def load(options={})

      attribs = Nanowrimo.parse(load_field,id,self.class::FIELDS,options).first
      self.error = attribs[:error]
      self.class::FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
      end
    end

    # Returns the values for all attributes for a given WCAPI type's history
    #
    # Options:
    #
    # * :force - if set to true, will force Nanowrimo data to be pulled from the WCAPI and ignore cache data. not really recommended for bandwidth reasons.
    def load_history(options={})
      self.history = Nanowrimo.parse(load_history_field,id,self.class::HISTORY_FIELDS,options)
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