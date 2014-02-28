require 'organews/config'

module Organews
  class Builder
    include Utils

    def initialize
      @src_path = Config.vars.src_path || "src"
      @views_path = Config.vars.views_path || "views"
      @pages_path = Config.vars.pages_path || "pages"
      @site_path = Config.vars.site_path || "site"
    end

    def make_letter(ymlfile)
      @c = to_ostruct(YAML::load_file(File.join(@src_path, ymlfile)))
      erb = ERB.new(File.read(File.join(@views_path, 'mail.html.erb')))
      File.open(File.join(@src_path, 'html', "#{@c.edition}.html"), 'w') do |f|
        f.puts erb.result(binding)
      end
      txt = ERB.new(File.read(File.join(@views_path, 'mail.txt.erb')))
      File.open(File.join(@src_path, 'txt', "#{@c.edition}.txt"), 'w') do |f|
        f.puts txt.result(binding)
      end
      FileUtils.cp(
        File.join(@src_path, ymlfile),
        File.join(@src_path, 'archives', "#{@c.edition}.yml")
      )

      letters = JSON.parse(File.read(File.join(@src_path, 'editions.json'))) rescue {}
      letters[@c.edition] = { link: "#{@c.edition}.html", date: @c.pubdate }
      File.open(File.join(@src_path, 'editions.json'),'w') do |f|
        f.puts letters.to_json
      end

      haml_engine = Haml::Engine.new(template)

      partial = ERB.new(File.read(File.join(@news_path, 'grn-partial.erb')))
      File.open(File.join(@news_path, 'partials', "GRN-#{@c.edition}.html"), 'w') do |f|
        f.puts partial.result(binding)
      end

      template = File.read(File.join(@views_path, 'static.haml'))
      page = OpenStruct.new
      page.letters = letters
      page.name = @c.edition
      page.content = File.read(File.join(@news_path, 'partials', "GRN-#{@c.edition}.html"))
      html = haml_engine.render(page)
      File.open(File.join(@static_path, "grn-#{page.name}.html"),'w') do |f|
        f.puts html
      end
      File.open(File.join(@static_path, 'index.html'),'w') do |f|
        f.puts html
      end
    end

  end
end
