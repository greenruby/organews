require 'yaml'
require 'erb'
require 'fileutils'
require 'rdiscount'
require 'haml'
require 'awesome_print'

YAML::ENGINE.yamler = 'psych'
ROOT = File.expand_path('../../../', __FILE__)
NEWS_PATH = File.join(ROOT, 'app', 'newsletters')
VIEWS_PATH = File.join(ROOT, 'views')
PAGES_PATH = File.join(ROOT, 'app', 'pages')

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
  task :letter do

    @c = to_ostruct(YAML::load_file(File.join(NEWS_PATH, 'grn.yml')))

    erb = ERB.new(File.read(File.join(NEWS_PATH, 'grn.html.erb')))
    File.open(File.join(NEWS_PATH, 'html', "GRN-#{@c.edition}.html"), 'w') do |f|
      f.puts erb.result
    end

    txt = ERB.new(File.read(File.join(NEWS_PATH, 'grn.txt.erb')))
    File.open(File.join(NEWS_PATH, 'txt', "GRN-#{@c.edition}.txt"), 'w') do |f|
      f.puts txt.result
    end

    partial = ERB.new(File.read(File.join(NEWS_PATH, 'grn-partial.erb')))
    File.open(File.join(NEWS_PATH, 'partials', "GRN-#{@c.edition}.html"), 'w') do |f|
      f.puts partial.result
    end

    template = File.read(File.join(VIEWS_PATH, 'static.haml'))
    haml_engine = Haml::Engine.new(template)
    letters = {}
    Dir.glob(File.join(NEWS_PATH, 'partials', '*.html')).sort.reverse.each do |v|
      k = File.basename(v,'.html').sub(/GRN-/,'')
      letters[k] = v
    end
    page = OpenStruct.new
    page.letters = letters
    page.name = @c.edition
    page.content = partial.result
    html = haml_engine.render(page)
    File.open("static/#{page.name}.html",'w') do |f|
      f.puts html
    end
    File.open("static/index.html",'w') do |f|
      f.puts html
    end

    FileUtils.cp(File.join(NEWS_PATH, 'grn.yml'), File.join(NEWS_PATH, 'archives', "grn-#{@c.edition}.yml"))
  end

  desc "updates static website"
  task :web do
    template = File.read(File.join(VIEWS_PATH, 'static.haml'))
    haml_engine = Haml::Engine.new(template)
    pages = Dir.glob(File.join(PAGES_PATH, '*.md'))
    letters = {}
    Dir.glob(File.join(NEWS_PATH, 'partials', '*.html')).sort.reverse.each do |v|
      k = File.basename(v,'.html').sub(/GRN-/,'')
      letters[k] = v
    end
    pages.each do |p|
      page = OpenStruct.new
      page.letters = letters
      page.name = File.basename(p, '.md')
      page.content = RDiscount.new(File.read(p)).to_html
      html = haml_engine.render(page)
      File.open("static/#{page.name}.html",'w') do |f|
        f.puts html
      end
      puts "static/#{page.name}.html .. refreshed"
    end
  end

end