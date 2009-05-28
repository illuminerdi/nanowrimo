#! /usr/bin/env ruby -w

module Nanowrimo
  class User < Core
    FIELDS = %w[uid uname user_wordcount]
    HISTORY_FIELDS = %w[wc wcdate]
    USER_FIELDS = %w[rid novel genre buddies]
    PROFILE_URI = "http://www.nanowrimo.org/eng/user"

    attr_accessor(*FIELDS)
    attr_accessor(*USER_FIELDS)
    attr_accessor :history, :profile_data
    def initialize uid
      @uid = uid
      @novel = {}
      @genre = {}
      @buddies = []
    end

    def id
      @uid
    end

    def load_field
      'wc'
    end

    def load_history_field
      'wchistory/wordcounts/wcentry'
    end

    def winner?
      self.user_wordcount.to_i >= Nanowrimo::GOAL
    end

    def load_profile_data
      # mechanize might be overkill, but at some point if they don't add more to the API
      # I'll have to dig deeper behind the site's authentication layer in order to pull out
      # some needed data.
      agent = WWW::Mechanize.new
      @profile_data = agent.get("#{PROFILE_URI}/#{@uid}")
    end

    def parse_profile
      load_profile_data
      # get the buddies
      @buddies = @profile_data.search("div[@class='buddies']//a").map{|b| b['href'].split('/').last; }
      @buddies.reject!{|b| b.to_i == 0}
      # title and genre are in the same element
      titlegenre = @profile_data.search("div[@class='titlegenre']").text.split("Genre:")
      @genre[:name] = titlegenre.last.strip
      @novel[:title] = titlegenre.first.gsub('Novel:','').strip
      # finally, the region is annoying to grab
      @rid = @profile_data.search("div[@class='infoleft']//a").first['href'].split('/').last
    end
  end
end