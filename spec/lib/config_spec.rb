# encoding: utf-8

require 'spec_helper'
require "organews/config"

describe Organews::Config do

  specify "#vars" do
    it "raises an error if there is no config.yml" do
      expect(Organews::Config.vars).to raise_error RuntimeError
    end
  end

end
