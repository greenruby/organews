#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require "rake/testtask"

require "rspec/core/rake_task" # RSpec 2.0

task :spec do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
    t.pattern = 'spec/**/*_spec.rb'
  end
end

task :default => :spec

desc "Scrape feeds and commit to mongo db"
task :scrape do
	require './lib/organews/mongo'
	require './lib/organews/engine/page'
	require './lib/organews/engine/rss'
	require 'mongo'
	require 'json'
	require 'time'
	include Organews
	include Organews::Mongo

	puts 'scraping feeds...'
	DB = Mongo::Connection.new.db("greenmongo", pool_size: 5, timeout: 5)
	feeds_str = DB.collection('feeds').find.to_a.map{ |t| frombsonid(t) }.to_json
	feeds = JSON.parse feeds_str
	feeds.each {|f| 
		puts f['title'] 

		feed_create_time = Time.parse(f['created_at'])
		passed_seconds = (Time.now - feed_create_time)
		puts "Last updated time is #{passed_seconds} seconds ago"
		# p f['items'][0]['published_at']
	}
end