$LOAD_PATH << File.expand_path('../..',__FILE__)

require 'coveralls'
Coveralls.wear!

ENV['RACK_ENV'] = 'test'


require "rspec"
