#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'

class TestUser < Test::Unit::TestCase
  def setup
    @user = Nanowrimo::User.new(240659)
  end
  
  def test_user_has_appropriate_fields
    expected = %w[uid uname user_wordcount]
    assert_equal expected, Nanowrimo::User::FIELDS
  end
  
  def test_new_user_gets_data
    assert @user.uid
    assert_equal 240659, @user.uid
    assert @user.uname
    assert_equal "hollowedout", @user.uname
    assert @user.user_wordcount
    assert_equal 55415, @user.user_wordcount
  end
end