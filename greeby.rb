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
  begin
    mongo_client = MongoClient.new("localhost", 27017).db("greenmongo", pool_size: 5, timeout: 5)
  rescue
    puts "Mongo disabled"
  end
end

Encoding.default_external = 'utf-8' if defined?(::Encoding)

class Greeby < Sinatra::Base


  register Sinatra::ConfigFile
  config_file 'config.yml'

  set :root, File.dirname(__FILE__)
  set :static, true
  set :public_folder, ->{ File.join(root, "static") }
  set :views, ->{ File.join(root, "views") }
  set :environments, %w{development test production}
  set :environment, :development
  set :sessions, true
  set :stats, { server: '', id: 0 }
  set :haml, :format => :html5

  configure :development, :test do
    get '/' do
      @title = 'wip (dev)'
      @stats = settings.stats
      haml :dev
    end
  end

  configure :production do
    get '/' do
      @title = 'wip'
      @stats = settings.stats
      haml :index
    end
  end

  get '/articles' do
    content_type :json
    { title: '1', url: 'aa' }.to_json
  end

  run! if app_file == $0
end
