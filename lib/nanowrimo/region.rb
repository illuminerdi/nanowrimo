#! /usr/bin/env ruby -w

module Nanowrimo
  # Handles Nanowrimo Region data.
  class Region < Core
    # fields expected from the main Region WCAPI
    FIELDS = %w[rid rname region_wordcount max min stddev average count donations numdonors]
    # fields expected from the Region history WCAPI
    HISTORY_FIELDS = %w[wc wcdate max min stddev average count donations donors]
    attr_accessor(*FIELDS)
    attr_accessor :history
    # creates a new Region object
    def initialize(rid)
      @rid = rid
    end
    
    # converts the WCAPI unique identifier for this type into a Nanowrimo::Core-friendly 'id'
    def id
      @rid
    end

    # converts the WCAPI path for this type into something Nanowrimo::Core-friendly
    def load_field
      'wcregion'
    end

    # converts the WCAPI history path for this type into something Nanowrimo::Core-friendly
    def load_history_field
      'wcregionhist/wordcounts/wcentry'
    end
  end
end