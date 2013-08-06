$LOAD_PATH << File.expand_path('../lib',__FILE__)

require 'rubygems'
require 'bundler'

require 'sinatra/base'
require "sinatra/config_file"

require 'mongo'
require 'json'

require 'organews'

DB = Mongo::Connection.new.db("greenmongo", pool_size: 5, timeout: 5)
UPDATE_INTERVAL_SECS = 1800

Encoding.default_external = 'utf-8' if defined?(::Encoding)

class App < Sinatra::Base

  include Organews::Mongo
  include Organews::Tools
  include Organews::Engine

  register Sinatra::ConfigFile
  config_file 'app/config/config.yml'

  set :root, File.dirname(__FILE__)
  set :static, true
  set :public_folder, ->{ File.join(root, "static") }
  set :views, ->{ File.join(root, "views") }
  set :environments, %w{development test production}
  set :environment, :development
  set :sessions, true
  set :stats, { server: '', id: 0 }

  configure :development do
    enable :logging
  end

  get '/' do
    @title = settings.appname
    erb :index
  end

  # will triggger scrapers if need
  get '/v1/feeds' do
    feeds = DB.collection('feeds').find.to_a.map{ |t| frombsonid(t) }
    has_update_feed = false
    feeds.each do |f| 
      
      if Time.now.to_i - f['updated_at'].to_i > UPDATE_INTERVAL_SECS
        begin
          rss = JSON.parse RSS.new(f['url']).to_json
        rescue
          break
        end
        new_items = rss['items'].select do |i|
          f['items'].select{ |old_i| old_i['digest'] == i['digest'] }.size == 0
        end
        unless new_items.empty?
          has_update_feed = true if !has_update_feed
        end
        DB.collection('feeds').update(
          { '_id' => tobsonid(f['id']) }, 
          { 
            '$push' => { 'items' => { '$each' => new_items } },
            '$set' => { 'updated_at' => Time.now }
          }
        )
      end
    end
    feeds = DB.collection('feeds').find.to_a.map{ |t| frombsonid(t) } if has_update_feed
    feeds.to_json
  end

  post '/v1/feeds' do
    request.body.rewind
    # hash['feed']['url'] = 'http://www.inside.com.tw/feed'
    now = Time.now
    rss = JSON.parse(RSS.new(params['url']).to_json)
    rss.merge!({ 'created_at' => now, 'updated_at' => now })

    oid = DB.collection("feeds").insert(rss)
    "{\"id\": \"#{oid.to_s}\"}"
  end

  get '/v1/:thing' do
    { params[:thing] => DB.collection(params[:thing]).find.to_a.map{ |t| frombsonid(t) } }.to_json
  end

  get '/v1/:thing/:id' do
    frombsonid(DB.collection(params[:thing]).find_one(tobsonid(params[:id]))).to_json
  end

  post '/v1/:thing' do
    request.body.rewind
    meat = params.dup
    ['splat', 'captures', 'thing'].each {|k| meat.delete(k)}
    if meat.empty?
      "{\"error\": \"no content provided for #{params[:thing]}\"}"
    else
      oid = DB.collection(params[:thing]).insert(JSON.parse(meat.to_json))
      "{\"id\": \"#{oid.to_s}\"}"
    end
  end

  delete '/v1/:thing/:id' do
    DB.collection(params[:thing]).remove( {'_id' => tobsonid(params[:id])} )
    "SUCCESS"
  end

  put '/v1/:thing/:id' do
    DB.collection(params[:thing]).update({
      'id' => tobsonid(params[:id])},
      {'$set' => JSON.parse(request.body.read.to_s).reject{|k,v| k == 'id'}
    })
  end

  get '/pages/:page' do
    page = clean(params[:page])
    if File.exist? "pages/#{page}.md"
      markdown File.read("pages/#{page}.md")
    end
  end

  run! if app_file == $0
end
