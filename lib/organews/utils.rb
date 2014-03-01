require 'ostruct'
require 'erb'
require 'tilt'

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

    def compile(ostruct, tpl, dest)
      Tilt.register Tilt::ERBTemplate, 'erb'
      output = Tilt::new(tpl).render(ostruct)
      File.open(dest, 'w') do |f|
        f.puts output
      end
      return output
    end

  end
end
