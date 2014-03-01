# encoding: utf-8

require 'spec_helper'
require "organews/utils"

class Dummy
end

describe Organews::Utils do

  let(:tmpdir) { File.expand_path("../../files/tmp",__FILE__) }

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

  describe "#compile" do
    let(:dest) { File.join(tmpdir, "sample.html") }
    after :each do
      FileUtils.rm dest if File.exist? dest
    end
    it "writes a compiled erb file" do
      ostruct = OpenStruct.new(title: "t", content: "c")
      tpl = File.expand_path("../../files/sample.html.erb",__FILE__)
      @dummy.compile ostruct, tpl, dest
      expect(File.exist? dest).to be_true
      expect(File.read dest).to eq "<h1>t</h1><div>c</div>\n"
    end
    it "writes a compiled haml file" do
      ostruct = OpenStruct.new(title: "t", content: "c")
      tpl = File.expand_path("../../files/sample.haml",__FILE__)
      @dummy.compile ostruct, tpl, dest
      expect(File.exist? dest).to be_true
      expect(File.read dest).to eq "<h1>\n  t\n</h1>\n<div>\n  c\n</div>\n"
    end
  end

end
