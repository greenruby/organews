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

class Greeby < Sinatra::Base

  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack
  assets {
    serve '/js', from: 'app/js'
    serve '/css', from: 'app/css'
    serve '/images', from: 'app/images'
    js :app, '/js/app.js', [
      '/js/vendor/**/*.js',
      '/js/lib/**/*.js'
    ]
    css :application, '/css/application.css', [
      '/css/screen.scss'
    ]
    js_compression  :jsmin    # :jsmin | :yui | :closure | :uglify
    css_compression :sass     # :simple | :sass | :yui | :sqwish
  }

  # register Sinatra::Ember
  # ember {
  #   templates ['templates/**/*.hbs'], :relative_to => 'templates'
  # }


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
