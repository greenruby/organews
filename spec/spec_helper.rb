$LOAD_PATH << File.expand_path('../..',__FILE__)

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

ENV['RACK_ENV'] = 'test'


require "rspec"
