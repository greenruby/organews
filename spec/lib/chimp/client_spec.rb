# encoding: utf-8

require 'spec_helper'
require "organews/chimp/client"

describe Organews::Chimp::Client do

  before :each do
    Organews::Config.load File.expand_path("../../../files/config.yml",__FILE__)
    @client = Organews::Chimp::Client.new
    @headers = {
      'Content-Type'=>'application/json',
      'Host'=>'us1.api.mailchimp.com:443',
      'User-Agent'=>'excon/0.32.0'
    }
  end

  after :each do
    Organews::Config.reset
  end

  describe "#ping" do
    it "calls mailchimp api and returns its response" do
      stub_request(:post, "https://us1.api.mailchimp.com/2.0/helper/ping.json").
        with(
          body: { apikey: Organews::Config.vars.chimp_key }.to_json,
          headers: @headers
        ).
        to_return(
          status: 200,
          body: { msg: "Everything's Chimpy!" }.to_json,
          headers: {}
        )
      @client.ping
    end
  end

  describe "#lists" do
    it "calls mailchimp api and returns its response" do
      stub_request(:post, "https://us1.api.mailchimp.com/2.0/lists/list.json").
        with(
          body: {
            filters: [],
            start: 0,
            limit: 25,
            sort_field: "created",
            sort_dir: "DESC",
            apikey: Organews::Config.vars.chimp_key
          }.to_json,
          headers: @headers
        ).
        to_return(
          status: 200,
          body: { data: [{ id: "1", name: 'test', stats: { member_count: "3" }}]}.to_json,
          headers: {}
        )
      @client.lists
    end
  end

  describe "#templates" do
    it "calls mailchimp api and returns its response" do
      stub_request(:post, "https://us1.api.mailchimp.com/2.0/templates/list.json").
        with(
          body: {
            types: [],
            filters: [],
            apikey: Organews::Config.vars.chimp_key
          }.to_json,
          headers: @headers
        ).
        to_return(
          status: 200,
          body: { user: [{ id: "1", name: 'test' }]}.to_json,
          headers: {}
        )
      @client.templates
    end
  end

  describe "#template_del" do
    it "calls mailchimp api and returns its response" do
      stub_request(:post, "https://us1.api.mailchimp.com/2.0/templates/del.json").
        with(
          body: {
            template_id: 1,
            apikey: Organews::Config.vars.chimp_key
          }.to_json,
          headers: @headers
        ).
        to_return(
          status: 200,
          body: { complete: true }.to_json,
          headers: {}
        )
      @client.template_del(1)
    end
  end

  describe "#campain_new" do
    it "creates a campain" do
      # stub_request
    end
  end

end
