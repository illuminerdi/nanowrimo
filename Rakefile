# -*- ruby -*-

$: << 'lib'
require 'rubygems'
require 'hoe'
require './lib/nanowrimo.rb'

Hoe.spec 'nanowrimo' do
  # p.rubyforge_name = 'nanowrimox' # if different than lowercase project name

  developer 'Joshua Clingenpeel', 'joshua.clingenpeel@gmail.com'

  extra_deps << ['mechanize','= 0.9.3']
  extra_dev_deps << ['fakeweb','= 1.2.7']

  version = Nanowrimo::VERSION
end

# vim: syntax=Ruby
