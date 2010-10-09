#! /usr/bin/env ruby -w

module Nanowrimo
  # Handles Nanowrimo User data.
  class User < Core
    # fields expected from the main User WCAPI
    FIELDS = %w[uid uname user_wordcount]
    # history fields expected from the User History WCAPI
    HISTORY_FIELDS = %w[wc wcdate]
    # fields needed to store data ripped from a user's profile page
    USER_FIELDS = %w[rid novel genre buddies]
    # profile page base URI
    PROFILE_URI = "http://www.nanowrimo.org/eng/user"

    attr_accessor(*FIELDS)
    attr_accessor(*USER_FIELDS)
    attr_accessor :history, :profile_data
    # creates a new User object
    def initialize uid
      @uid = uid
      @novel = {}
      @genre = {}
      @buddies = []
    end

    # converts the WCAPI 'uid' into a Nanowrimo::Core-friendly 'id'
    def id
      @uid
    end

    # converts the WCAPI path for this type into something Nanowrimo::Core-friendly
    def load_field
      'wc'
    end

    # converts the WCAPI history path for this type into something Nanowrimo::Core-friendly
    def load_history_field
      'wchistory/wordcounts/wcentry'
    end

    # Determines if the User's current wordcount meets the month's goal.
    def winner?
      self.user_wordcount.to_i >= Nanowrimo::GOAL
    end

    # Method to pull down a WWW::Mechanize::Page instance of the User's profile page
    def load_profile_data
      @profile_data = Nokogiri::HTML(open("#{PROFILE_URI}/#{@uid}"))
    end

    # Parses the profile page data pulling out extra information for the User.
    def parse_profile
      load_profile_data
      # get the buddies
      @buddies = @profile_data.search("div[@class='buddies']//a").map{|b| b['href'].split('/').last; }
      @buddies.reject!{|b| b.to_i == 0}
      # title and genre are in the same element
      titlegenre = @profile_data.search("div[@class='titlegenre']").text.split("Genre:")
      unless titlegenre.empty?
        @genre[:name] = titlegenre.last.strip
        @novel[:title] = titlegenre.first.gsub('Novel:','').strip
      else
        @genre[:name] = ""
        @novel[:title] = ""
      end
      # finally, the region is annoying to grab
      @rid = @profile_data.search("div[@class='infoleft']//a").first['href'].split('/').last
      nil
    end
  end
end