#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'
require 'fakeweb'

class TestGenre < Test::Unit::TestCase
  def setup
    @genre = Nanowrimo::Genre.new("13")
  end

  def test_genre_has_appropriate_fields
    expected = %w[gid gname genre_wordcount max min stddev average count]
    assert_equal expected, Nanowrimo::Genre::FIELDS
  end

  def test_genre_has_appropriate_history_fields
    expected = %w[wc wcdate max min stddev average count]
    assert_equal expected, Nanowrimo::Genre::HISTORY_FIELDS
  end

  def test_genre_loads_current_data
    file = 'test/fixtures/genre_wc.xml'
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wcgenre/13", :body => file)
    @genre.load
    Nanowrimo::Genre::FIELDS.each do |f|
      assert @genre.send(:"#{f}")
    end
  end

  def test_genre_loads_historical_data
    file = 'test/fixtures/genre_wc_history.xml'
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wcgenrehist/13", :body => file)
    @genre.load_history
    assert @genre.history
    # So...
    # It looks like the API for the genre history data is borked. I've sent an email to the
    # nanowrimo peoples, and when they bring it back up properly I'll test more thoroughly.
    assert_equal 0, @genre.history.size
    #assert_equal 7, @genre.history.first.size
  end

  def test_unknown_genre_produces_error_data
   bad_genre = Nanowrimo::Genre.new("999999")
   file = "test/fixtures/genre_wc_error.xml"
   FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wcgenre/999999", :body => file)
   bad_genre.load
   assert bad_genre.has_error?
   assert_equal "genre not found", bad_genre.error
  end

  def test_unknown_genre_produces_historical_error_data
    bad_genre = Nanowrimo::Genre.new("999999")
    file = "test/fixtures/genre_wc_history_error.xml"
    FakeWeb.register_uri(:any, "#{Nanowrimo::API_URI}/wcgenrehist/999999", :body => file)
    bad_genre.load_history
    assert bad_genre.has_error?
    assert_equal "genre not found", bad_genre.error
  end
end