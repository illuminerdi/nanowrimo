# -*- ruby -*-

$: << 'lib'
require 'rubygems'
require 'hoe'
require './lib/nanowrimo.rb'

Hoe.spec 'nanowrimo' do
  # p.rubyforge_name = 'nanowrimox' # if different than lowercase project name

  developer 'Joshua Clingenpeel', 'joshua.clingenpeel@gmail.com'

  extra_deps << ['nokogiri','= 1.4.3.1']
  extra_dev_deps << ['fakeweb','= 1.2.7']

  version = Nanowrimo::VERSION
end

# vim: syntax=Ruby
