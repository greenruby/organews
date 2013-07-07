require 'spec_helper'
require 'nokogiri'
require 'lib/greeby/engine/rss.rb'

describe Greeby::Engine::RSS do
	before(:each) do
		@rss_source = "spec/dummies/fakerss.xml"
	end

  it "initialize feeds array and Nokogiri XML object by given source" do
    rss = Greeby::Engine::RSS.new @rss_source
    expect(rss.feeds).to eq []
    expect(rss.xml).to be_an_instance_of Nokogiri::XML::Document
  end

  it "can parse rss feed" do
  	rss = Greeby::Engine::RSS.new @rss_source
  	rss.parse
  	expect(rss.feeds.count).to be > 0
  	rss.feeds.each do |f|
  		f.should respond_to :title
  		f.should respond_to :link
  		f.should respond_to :published_at
  	end
 	end

end