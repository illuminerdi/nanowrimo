#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'
require 'fakeweb'

class TestUser < Test::Unit::TestCase
  def setup
    @user = Nanowrimo::User.new("240659")
    FakeWeb.allow_net_connect = false
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
    @user.load_profile_data
    assert @user.profile_data.instance_of?(WWW::Mechanize::Page)
    assert_match(/<div id="tcontent3"/, @user.profile_data.body)
  end

  def test_find_users_region
    profile_uri_setup
    @user.parse_profile
    assert_equal "84", @user.rid
  end

  def test_find_users_novel_title
    profile_uri_setup
    @user.parse_profile
    assert_equal "Interpolis", @user.novel[:title]
  end

  def test_find_users_genre
    profile_uri_setup
    @user.parse_profile
    assert_equal "Science Fiction", @user.genre[:name]
  end

  def test_find_users_buddies
    profile_uri_setup
    @user.parse_profile
    assert @user.buddies.instance_of?(Array)
    assert_equal 11, @user.buddies.size
  end
  
  def test_unknown_user_produces_error_data
   bad_user = Nanowrimo::User.new("999999")
   file = "test/fixtures/user_wc_error.xml"
   FakeWeb.register_uri("#{Nanowrimo::API_URI}/wc/999999", :file => file)
   bad_user.load
   assert bad_user.has_error?
   assert_equal "user not found or is inactive", bad_user.error
  end
  
  def test_unknown_user_produces_historical_error_data
    bad_user = Nanowrimo::User.new("999999")
    file = "test/fixtures/user_wc_history_error.xml"
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wchistory/999999", :file => file)
    bad_user.load_history
    assert bad_user.has_error?
    assert_equal "user not found or is inactive", bad_user.error 
  end
  
  def profile_uri_setup
    # this was a bit of weirdness - I had to curl -is the url in order to grab the headers, and
    # even then it would register the file from FakeWeb as WWW::Mechanize::File, not WWW::Mechanize::Page
    # discussion started at http://groups.google.com/group/fakeweb-users/browse_thread/thread/e01b6280e720ae6f
    file = File.read("test/fixtures/user_page.htm")
    FakeWeb.register_uri("http://www.nanowrimo.org/eng/user/240659", :response => file)
  end
end