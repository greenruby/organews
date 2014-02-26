# encoding: utf-8

require 'spec_helper'
require "organews/cli"

describe Organews::Cli do

  before :each do
    @cli = Organews::Cli.new([], {'configfile' => 'config.yml'})
    @testdir = File.join('spec','files','test-client')
  end

  describe "#init" do

    after :each do
      FileUtils.rm_rf @testdir if Dir.exists? @testdir
    end

    it "creates a working directory" do
      @cli.shell.mute do
        @cli.init @testdir
      end
      expect(File.file? 'config.yml').to be_true
    end
  end

end
