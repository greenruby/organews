require 'yaml'
require 'erb'
require 'fileutils'

WHERE = File.expand_path('../../../newsletters/', __FILE__)

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
  return result
end

namespace :generate do

  desc "generate a new letter html file"
  task :html do
    @c = to_ostruct(YAML::load_file(File.join(WHERE, 'grn.yml')))
    erb = ERB.new(File.read(File.join(WHERE, 'grn.html.erb')))
    File.open(File.join(WHERE, 'html', "GRN-#{@c.edition}.html"), 'w') do |f|
      f.puts erb.result
    end
    FileUtils.cp(File.join(WHERE, 'grn.yml'), File.join(WHERE, 'archives', "grm-#{@c.edition}.yml"))
  end

end