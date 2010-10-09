= nanowrimo

* http://nanowrimo.rubyforge.org/
* http://rubygems.org/gems/nanowrimo
* http://github.com/illuminerdi/nanowrimo
* http://rubydoc.info/gems/nanowrimo/0.8.0/frames

With special thanks to the folks at:

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
* Caching is somewhat smart, with the ability to bypass it if there's a problem with cached data, and also the ability to completely clear all current cached data.
* Errors from the WCAPI are handled gracefully.

Problems:
* The Genres API on Nanowrimo.org is a little broken right now, so there's not much data to be loaded. UPDATE: This is still the case, and may or may not have anything to do with load on nanowrimo.org. I'll keep checking up on it.
* Page scraping is dumb and costly. And the data I get is minimal. Submitted request for new API features with Nanowrimo.org crew.
* Caching is still fairly immature in this package, but getting bettar. UPDATE: really, it's not so bad.

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
  => ["94450", "208549", "236224", "244939", ...

  # Want an array of day-by-day progress for yourself?
  >> me.load_history

  # Want an array of day-by-day progress for your region?
  >> my_region = Nanowrimo::Region.new(84)
  >> my_region.load_history

== REQUIREMENTS:

* ruby 1.8.7 or 1.9.2 (tested in both)
* nokogiri 1.4.3.1

== INSTALL:

* gem install nanowrimo

== LICENSE:

(The MIT License)

Copyright (c) 2010 Joshua Clingenpeel

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
