# encoding: utf-8

require 'spec_helper'
require "organews/config"

describe Organews::Config do

  before :each do
    Organews::Config.reset
  end

  describe "#load" do

    it "loads config file" do
      file = File.expand_path("../../../templates/config.yml",__FILE__)
      Organews::Config.load file
      expect( Organews::Config.instance_variable_get(:@__configfile)).to eq file
    end

  end

  describe "#reset" do

    it "resets the configuration" do
      Organews::Config.load File.expand_path("../../../templates/config.yml",__FILE__)
      Organews::Config.vars
      expect( Organews::Config.instance_variables.count ).to be 2
      Organews::Config.reset
      expect( Organews::Config.instance_variables.count ).to be 0
    end

  end

  describe "#vars" do

    context "with no config file loaded" do
      it "raises an error if there is no config.yml" do
        expect{ Organews::Config.vars }.to raise_error(RuntimeError)
      end
      it "explains how to create config file" do
        expect{ Organews::Config.vars }.to raise_error("Missing configuration file, run `organews init` or create a config.yml file.")
      end
    end

    context "with the default config file set" do
      before :each do
        Organews::Config.load File.expand_path("../../../templates/config.yml",__FILE__)
      end
      it "gets you the structs of config vars" do
        expect( Organews::Config.vars ).to be_an OpenStruct
      end
      it "returns the content of the config file as values" do
        expect( Organews::Config.vars.host ).to eq "name"
      end
    end

  end

end
