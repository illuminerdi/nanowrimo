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
  
  def test_find_users_region
    # TODO: implement a method that scrapes the region_id from their nanowrimo profile page
  end
  
  def test_find_users_novel_title
    # TODO: implement a method that scrapes the novel title from their nanowrimo profile page
  end
  
  def test_find_users_genre
    # TODO: implement a method that scrapes the genre_id from their nanowrimo profile page
  end
  
  def test_find_users_buddies
    # TODO: implement a method that scrapes the uids of all a given user's buddies from their nanowrimo profile page
  end
end