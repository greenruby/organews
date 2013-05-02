require 'rubygems'
require 'bundler'

require 'sinatra'
require "sinatra/config_file"

require 'mongo'
require 'json'

Bundler.require


# detect appfog environment
if ENV['VCAP_SERVICES']
else
end

DB = Mongo::Connection.new.db("greenmongo", pool_size: 5, timeout: 5)

class Greeby < Sinatra::Base
  register Sinatra::ConfigFile

  config_file 'config.yml'

  set :public_folder, File.dirname(__FILE__) + '/static'
  set :haml, :format => :html5
  set :views, ['views']
  set :environments, %w{development test production}

  get '/' do
    @config = settings
    @title = 'wip'
    haml :index
  end

  run! if app_file == $0
end
