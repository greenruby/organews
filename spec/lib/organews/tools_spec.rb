require_relative '../../spec_helper'
require 'lib/organews/tools.rb'

describe Organews::Tools do

  include Organews::Tools

  it ".clean(str) cleans names very strictly" do
    str = "a.b-cde()"
    expected = "abcde"
    expect(clean(str)).to eq expected
  end

end