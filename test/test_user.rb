#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'
require 'fakeweb'

class TestUser < Test::Unit::TestCase
  def setup
    @user = Nanowrimo::User.new("240659")
  end

  def test_user_has_appropriate_fields
    expected = %w[uid uname user_wordcount]
    assert_equal expected, Nanowrimo::User::FIELDS
  end

  def test_user_has_appropriate_historical_fields
    expected = %w[wc wcdate]
    assert_equal expected, Nanowrimo::User::HISTORY_FIELDS
  end

  def test_user_has_uid
    assert_equal "240659", @user.uid
  end

  def test_user_gets_data
    file = "test/fixtures/user_wc.xml"
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wc/240659", :file => file)
    @user.load
    assert @user.uname
    assert_equal "hollowedout", @user.uname
    assert @user.user_wordcount
    assert_equal "55415", @user.user_wordcount
  end

  def test_user_loads_history_data
    file = "test/fixtures/user_wc_history.xml"
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wchistory/240659", :file => file)
    @user.load_history
    assert @user.history
    assert_equal 30, @user.history.size
  end

  def test_user_is_a_winner
    @user.load
    assert @user.winner?
  end
  
  def test_user_has_profile_fields
    expected = %w[rid novel genre buddies]
    assert_equal expected, Nanowrimo::User::USER_FIELDS
  end
  
  def test_profile_fields_default_properly
    assert @user.novel.instance_of?(Hash)
    assert @user.genre.instance_of?(Hash)
    assert @user.buddies.instance_of?(Array)
  end
  
  def test_user_load_profile_data
    profile_uri_setup
    @user.load_profile_page
    assert_match /<div id="tcontent3"/, @user.profile_page.body
  end

  def test_find_users_region
    # TODO: implement a method that scrapes the region_id from their nanowrimo profile page
    profile_uri_setup
    @user.parse_profile
    assert_equal 84, @user.rid
  end

  def test_find_users_novel_title
    # TODO: implement a method that scrapes the novel title from their nanowrimo profile page
    profile_uri_setup
    @user.parse_profile
    assert_equal "Interpolis", @user.novel[:title]
  end

  def test_find_users_genre
    # TODO: implement a method that scrapes the genre_id from their nanowrimo profile page
    profie_uri_setup
    @user.parse_profile
    assert_equal "Science Fiction", @user.genre[:name]
  end

  def test_find_users_buddies
    # TODO: implement a method that scrapes the uids of all a given user's buddies from their nanowrimo profile page
    profile_uri_setup
    @user.parse_profile
    assert @user.buddies.instance_of?(Array)
    assert_equal 11, @user.buddies.size
  end
  
  def profile_uri_setup
    file = "test/fixtures/user_page.htm"
    FakeWeb.register_uri("#{Nanowrimo::User::PROFILE_URI}/240659", :file => file)
  end
end