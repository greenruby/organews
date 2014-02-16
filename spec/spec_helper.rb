$LOAD_PATH << File.expand_path('../../lib',__FILE__)

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

ENV['RACK_ENV'] = 'test'

require "rspec"

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
