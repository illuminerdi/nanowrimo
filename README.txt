= nanowrimo

* http://nanowrimo.rubyforge.org
* http://github.com/illuminerdi/nanowrimo
* http://www.nanowrimo.org

== DESCRIPTION:

A simple API wrapper for Nanowrimo.org. Nanowrimo Word Count API documentation here:
http://www.nanowrimo.org/eng/wordcount_api

== FEATURES/PROBLEMS:

Features:
* Simple! Clean! Well-tested!
* Easy to roll into a Rails application (that's next)
* Separate APIs for Users, Site, Regions, and Genres
* API handles generated error messages from the WCAPI
* Page scraping place for basic user data from the profile page
* Caches data to avoid November bandwidth issues

Problems:
* The Genres API on Nanowrimo.org is a little broken right now, so there's not much data to be loaded.
* Page scraping is dumb and costly. And the data I get is minimal. Submitted request for new API features with Nanowrimo.org crew.
* Caching is still fairly immature in this package. Need to tune it further before November hits.

== SYNOPSIS:

  >> me = Nanowrimo::User.new(240659)
  => #<Nanowrimo::User:0x105b904 @uid=240659>
  >> me.load
  => ["uid", "uname", "user_wordcount"]
  >> me.user_wordcount
  => "55415"
  >> me.winner?
  => true
  # YAY!

  # Want to get a list of your writing buddies?
  >> me.parse_profile
  >> me.buddies
  => ["94450", "208549", "236224", "244939", "301080", "405136", "139709", "229531", "240149", "245095", "309620"]

  # Want an array of day-by-day progress for yourself?
  >> me.load_history

  # Want an array of day-by-day progress for your region?
  >> my_region = Nanowrimo::Region.new(84)
  >> my_region.load_history

== REQUIREMENTS:

* ruby 1.8.6
* mechanize 0.9.2

== INSTALL:

* sudo gem install nanowrimo

== LICENSE:

(The MIT License)

Copyright (c) 2009 Joshua Clingenpeel

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
