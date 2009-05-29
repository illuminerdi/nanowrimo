#! /usr/bin/env ruby -w

module Nanowrimo
  # Handles Nanowrimo Genre data.
  class Genre < Core
    # fields expected from the main Genre WCAPI
    FIELDS = %w[gid gname genre_wordcount max min stddev average count]
    # fields expected from the Region history WCAPI
    HISTORY_FIELDS = %w[wc wcdate max min stddev average count]
    attr_accessor(*FIELDS)
    attr_accessor :history
    # creates a new Region object
    def initialize(gid)
      @gid = gid
    end

    # converts the WCAPI unique identifier for this type into a Nanowrimo::Core-friendly 'id'
    def id
      @gid
    end

    # converts the WCAPI path for this type into something Nanowrimo::Core-friendly
    def load_field
      'wcgenre'
    end

    # converts the WCAPI history path for this type into something Nanowrimo::Core-friendly    
    def load_history_field
      'wcgenrehist/wordcounts/wcentry'
    end
  end
end