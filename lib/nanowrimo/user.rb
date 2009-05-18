#! /usr/bin/env ruby -w

module Nanowrimo
  class User
    FIELDS = %w[uid uname user_wordcount]
    HISTORY_FIELDS = %w[]
    attr_reader(*FIELDS)
    def initialize uid
      "Hello, world!"
    end
  end
end