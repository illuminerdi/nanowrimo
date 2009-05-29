#! /usr/bin/env ruby -w

module Nanowrimo
  # Handles Nanowrimo Site data.
  class Site < Core
    # fields expected from the main Site WCAPI
    FIELDS = %w[site_wordcount max min stddev average count]
    # fields expected from the Site history WCAPI
    HISTORY_FIELDS = %w[wc wcdate max min stddev average count]
    attr_accessor(*FIELDS)
    attr_accessor :history
    # converts the WCAPI unique identifier for this type into a Nanowrimo::Core-friendly 'id'
    def id
      nil
    end

    # converts the WCAPI path for this type into something Nanowrimo::Core-friendly
    def load_field
      'wcstatssummary'
    end

    # converts the WCAPI history path for this type into something Nanowrimo::Core-friendly
    def load_history_field
      'wcstats/wordcounts/wcentry'
    end
  end
end