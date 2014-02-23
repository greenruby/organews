require 'organews/config'

module Organews
  class Builder
    include Utils

    def initialize
      @src_path = Config.vars.news_path || "src"
      @views_path = Config.vars.news_path || "views"
      @pages_path = Config.vars.news_path || "pages"
      @site_path = Config.vars.news_path || "site"
    end

  end
end
