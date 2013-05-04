require 'rubygems'
require 'bundler'

require 'sinatra/base'
require "sinatra/config_file"

require 'mongo'
require 'json'
require 'awesome_print'

Bundler.require


# detect appfog environment
if ENV['VCAP_SERVICES']
else
end

unless ENV['RACK_ENV'] == 'test'
  mongo_client = MongoClient.new("localhost", 27017).db("greenmongo", pool_size: 5, timeout: 5)
end

class Greeby < Sinatra::Base
  register Sinatra::ConfigFile

  config_file 'config.yml'

  set :public_folder, File.dirname(__FILE__) + '/static'
  set :haml, :format => :html5
  set :views, ['views']
  set :environments, %w{development test production}
  set :stats, { server: '', id: 0 }

  get '/' do
    @title = 'wip'
    @stats = settings.stats
    haml :index
  end

  run! if app_file == $0
end
