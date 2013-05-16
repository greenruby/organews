require 'rubygems'
require 'bundler'

require 'sinatra/base'
require "sinatra/config_file"
require 'sinatra/assetpack'
require 'compass'
require 'sinatra/support'

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

  helpers Sinatra::ContentFor
  helpers Sinatra::UserAgentHelpers
  helpers Rtopia

  set :root, File.dirname(__FILE__)

  register Sinatra::CompassSupport
  c = Compass.configuration
  c.project_path = root
  c.images_dir = "static/icons"
  c.http_generated_images_path = "/images"

  register Sinatra::Ember
  ember {
    templates '/app/js/templates.js', ['templates/**/*.hbs'], :relative_to => 'templates'
  }

  register Sinatra::AssetPack
  assets do
    js :app, '/app.js', %w[
      /js/vendor/*.js
      /js/lib/*.js
      /js/app/*.js
    ]
    css :main, '/main.css', %w[
      css/screen.scss
    ]
    js_compression  :jsmin    # :jsmin | :yui | :closure | :uglify
    css_compression :sass     # :simple | :sass | :yui | :sqwish
  end

  configure :development do
    require 'pistol'
    use(Pistol, Dir[root("./{lib,app}/**/*.rb")]) { reset! and load(root('init.rb')) }
  end


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
