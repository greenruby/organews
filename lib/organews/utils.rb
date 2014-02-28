require 'ostruct'
require 'erb'
require 'haml'

module Organews
  module Utils

    def to_ostruct(obj)
      result = obj
      if result.is_a? Hash
        result = result.dup
        result.each do |key, val|
          result[key] = to_ostruct(val)
        end
        result = OpenStruct.new result
      elsif result.is_a? Array
        result = result.map { |r| to_ostruct(r) }
      end
      result
    end

    def write_erb(ostruct, tpl, dest)
      erb = ERB.new(File.read(tpl)).result(ostruct.instance_eval { binding })
      File.open(dest, 'w') do |f|
        f.puts erb
      end
      return erb
    end

    def write_haml(ostruct, tpl, dest)
      haml = Haml::Engine.new(File.read(tpl)).render(ostruct.instance_eval { binding })
      File.open(dest, 'w') do |f|
        f.puts haml
      end
      return haml
    end

  end
end
