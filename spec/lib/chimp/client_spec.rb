# encoding: utf-8

require 'spec_helper'
require "organews/chimp/client"

describe Organews::Chimp::Client do

  before :each do
    Organews::Config.load File.expand_path("../../../files/config.yml",__FILE__)
    @client = Organews::Chimp::Client.new
  end

  after :each do
    Organews::Config.reset
  end

  describe "#ping" do
    it "calls mailchimp api and returns its response" do
      stub_request(:post, "https://us1.api.mailchimp.com/2.0/helper/ping.json").
        with(
          body: { apikey: Organews::Config.vars.chimp_key }.to_json,
          headers: {
            'Content-Type'=>'application/json',
            'Host'=>'us1.api.mailchimp.com:443',
            'User-Agent'=>'excon/0.31.0'
          }
        ).
        to_return(
          status: 200,
          body: { msg: "Everything's Chimpy!" }.to_json,
          headers: {}
        )
      @client.ping
    end
  end

end
