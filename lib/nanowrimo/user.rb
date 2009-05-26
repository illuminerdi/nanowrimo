#! /usr/bin/env ruby -w

module Nanowrimo
  class User
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

    def load
      attribs = Nanowrimo.parse('wc', @uid, FIELDS).first
      FIELDS.each do |attrib|
        self.send(:"#{attrib}=", attribs[attrib.intern])
      end
    end

    def load_history
      @history = Nanowrimo.parse('wchistory/wordcounts/wcentry', @uid, HISTORY_FIELDS)
    end

    def winner?
      self.user_wordcount.to_i >= Nanowrimo::GOAL
    end
    
    def load_profile_data
      agent = WWW::Mechanize.new
      @profile_data = agent.get("#{PROFILE_URI}/#{@uid}")
    end
    
    def parse_profile
      load_profile_data
      # get the buddies
      @profile_data.links.each do |link|
        if link.href =~ /\/eng\/user/
          @buddies << link.href.split('/').last
        end
      end
      @buddies.uniq!
      @buddies.delete @uid
      # title and genre are in the same element
      titlegenre = @profile_data.search("div[@class='titlegenre']").text.split("Genre:")
      @genre[:name] = titlegenre.last.strip
      @novel[:title] = titlegenre.first.gsub('Novel:','').strip
      # finally, the region is annoying to grab
      @rid = @profile_data.search("div[@class='infoleft']//a").first['href'].split('/').last
    end
  end
end