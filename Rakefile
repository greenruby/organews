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

namespace :db do
	desc 'Reset mongodb, all data will be deleted'
	task :reset do
		require 'mongo'
		
		DB = Mongo::Connection.new.db("greenmongo", pool_size: 5, timeout: 5)
		collections = DB.collection_names.reject { |c| c == 'system.indexes' }
		collections.each do |c|
			DB.collection(c).drop()
		end
	end
end