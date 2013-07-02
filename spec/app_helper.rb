require_relative './spec_helper'
require "rack/test"
require 'sinatra'
require 'app'

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  App
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
