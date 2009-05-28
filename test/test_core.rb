#! /usr/bin/env ruby -w

require 'nanowrimo'
require 'test/unit'

class TestCore < Test::Unit::TestCase
  # basically we're just making sure that the methods we need are present. the class was
  # created as a refactor of the common methods in each of the Nanowrimo::* classes.
  def test_core_has_load_method
    assert Nanowrimo::Core.new.respond_to?(:load)
  end
  
  def test_core_has_load_history_method
    assert Nanowrimo::Core.new.respond_to?(:load_history)
  end
end