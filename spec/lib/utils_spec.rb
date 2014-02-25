# encoding: utf-8

require 'spec_helper'
require "organews/utils"

class Dummy
end

describe Organews::Utils do

  before :each do
    @dummy = Dummy.new
    @dummy.extend(Organews::Utils)
  end

  describe "#to_ostruct" do
    it "transforms a hash into a stuct recursively" do
      hash = { b: '', a: { aa: 'aa' }, d: 'd', c: [cb: ['b', 'a', 'c'], ca: { caa: 'caa' }] }
      s = @dummy.to_ostruct hash
      expect(s).to be_an OpenStruct
      expect(s.a).to be_an OpenStruct
      expect(s.a.aa).to eq 'aa'
      expect(s.c).to be_an Array
      expect(s.c[0].cb).to be_an Array
      expect(s.c[0].cb[0]).to eq 'b'
    end
  end

end
