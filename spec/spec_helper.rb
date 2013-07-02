$LOAD_PATH << File.expand_path('../..',__FILE__)

if ENV['COV']
  require 'simplecov'
  require 'coveralls'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/config/'
    add_filter '/db/'
    add_group 'Models', '/app/models/'
    add_group 'Controllers', '/app/controllers/'
    add_group 'Helpers', '/app/helpers/'
    add_group 'Lib', '/lib/'
  end
end

ENV['RACK_ENV'] = 'test'


require "rspec"
