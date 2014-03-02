require 'organews/config'
require 'organews/utils'

module Organews
  class Builder
    include Utils

    def initialize(yamlfile)
      @src_path = Config.vars.src_path || "src"
      @views_path = Config.vars.views_path || "views"
      @pages_path = Config.vars.pages_path || "pages"
      @site_path = Config.vars.site_path || "site"
      @c = to_ostruct(YAML::load_file(File.join(@src_path, ymlfile)))
    end

    def make_letter(ymlfile)
      compile @c, File.join(@views_path, 'mail.html.erb'), File.join(@src_path, 'html', "#{@c.edition}.html")
      compile @c, File.join(@views_path, 'mail.txt.erb'), File.join(@src_path, 'txt', "#{@c.edition}.txt")

      FileUtils.cp File.join(@src_path, ymlfile), File.join(@src_path, 'archives', "#{@c.edition}.yml")

      @c.content = write_haml @c, File.join(@views_path, 'content.haml'), File.join(@src_path, 'content', "#{@c.edition}.html")
      compile @c, File.join(@views_path, 'index.haml'), File.join(@site_path, "#{@c.edition}.html")

      @c.edition = nil
      compile @c, File.join(@views_path, 'index.haml'), File.join(@site_path, "index.html")
    end

    def letters
      Dir.glob(File.join(@src_path, 'archives', '*.yml')).map do |d|
        File.basename(d, '.yml')
      end.sort
    end

  end
end
