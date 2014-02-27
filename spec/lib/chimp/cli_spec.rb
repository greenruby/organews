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

end
