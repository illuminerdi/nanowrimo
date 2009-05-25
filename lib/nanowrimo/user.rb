#! /usr/bin/env ruby -w

module Nanowrimo
  class User
    FIELDS = %w[uid uname user_wordcount]
    HISTORY_FIELDS = %w[wc wcdate]
    USER_FIELDS = %w[rid novel genre buddies]
    PROFILE_URI = "http://www.nanowrimo.org/eng/user"

    attr_accessor(*FIELDS)
    attr_accessor(*USER_FIELDS)
    attr_accessor :history
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
  end
end