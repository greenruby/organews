# encoding: utf-8

require 'spec_helper'
require "organews/chimp/cli"

describe Organews::Chimp::Cli do

  before :each do
    @cli = Organews::Chimp::Cli.new([], {
      'configfile' => File.expand_path('../../../files/config.yml', __FILE__)
    } )
  end

  describe "#check" do
    it "responds to ping" do
      Organews::Chimp::Client.stub(:new).and_return(Object)
      Object.stub(:ping) { "ha" }
      expect(@cli).to receive(:say).with(subject.set_color "All good.", :green, :bold)
      @cli.shell.mute do
        @cli.check
      end
    end
    it "raises en error if api key is wrong" do
      Organews::Chimp::Client.stub(:new).and_return(Object)
      Object.stub(:ping).and_raise("invalid key")
      expect(@cli).to receive(:say).with(subject.set_color "*** Error ***", :red, :bold)
      expect(@cli).to receive(:say).with(subject.set_color "invalid key", :red)
      @cli.shell.mute do
        @cli.check
      end
    end
  end

  describe "#lists" do
    it "responds to lists" do
      Organews::Chimp::Client.stub(:new).and_return(Object)
      Object.stub(:lists).and_return([{ id: 1, name: 'test', members: 3 }])
      expect(@cli).to receive(:say).
        with(
          sprintf("%12s %-20s %s", subject.set_color("1", :cyan), 'test', '3')
        )
      @cli.shell.mute do
        @cli.lists
      end
    end
    it "raises en error if something is wrong" do
      Organews::Chimp::Client.stub(:new).and_return(Object)
      Object.stub(:lists).and_raise("error occured")
      expect(@cli).to receive(:say).with(subject.set_color "*** Error ***", :red, :bold)
      expect(@cli).to receive(:say).with(subject.set_color "error occured", :red)
      @cli.shell.mute do
        @cli.lists
      end
    end
  end

  describe "#templates" do
    it "responds to templates" do
      Organews::Chimp::Client.stub(:new).and_return(Object)
      Object.stub(:templates).and_return([{ id: 1, name: 'test' }])
      expect(@cli).to receive(:say).
        with(
          sprintf("%12s %s", subject.set_color("1", :cyan), 'test')
        )
      @cli.shell.mute do
        @cli.templates
      end
    end
    it "raises en error if something is wrong" do
      Organews::Chimp::Client.stub(:new).and_return(Object)
      Object.stub(:templates).and_raise("error occured")
      expect(@cli).to receive(:say).with(subject.set_color "*** Error ***", :red, :bold)
      expect(@cli).to receive(:say).with(subject.set_color "error occured", :red)
      @cli.shell.mute do
        @cli.templates
      end
    end
  end

  describe "#template" do
    it "responds to templates del" do
      Organews::Chimp::Client.stub(:new).and_return(Object)
      Object.stub(:template_del).with(1) { "ok" }
      expect(@cli).to receive(:say).with("ok")
      @cli.shell.mute do
        @cli.template('del',1)
      end
    end
    it "raises en error if something is wrong" do
      Organews::Chimp::Client.stub(:new).and_return(Object)
      Object.stub(:template_del).with(1).and_raise("error occured")
      expect(@cli).to receive(:say).with(subject.set_color "*** Error ***", :red, :bold)
      expect(@cli).to receive(:say).with(subject.set_color "error occured", :red)
      @cli.shell.mute do
        @cli.template('del',1)
      end
    end
  end

end
