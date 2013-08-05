require 'feedzirra'

module Organews
  module Engine
    class RSS
      attr_accessor :channel, :url, :items, :xml

      def initialize(url)
        @url = url
        @items = []
        feed = Feedzirra::Feed.fetch_and_parse(url)
        @channel = feed.title
        @language = feed.language || feed.entries.first.language
        threads = []
        feed.entries.each do |e|
          item = { language: e.language, title: e.title, link: e.url, digest: Digest::MD5.hexdigest(e.id), published_at: e.published }
          content = e.content
          if content.nil?
            threads << Thread.new {
              begin
                item[:content] = Page.new(link).content
              rescue
                item[:content] = "Error in parsing content"
              end
              @items << item
            }
          else
            item[:content] = content
            @items << item
          end
        end
        threads.each { |t| t.join }
      end

      def digest
        Digest::MD5.hexdigest @url
      end

      def to_json(options = {})
        {
          channel: @channel,
          language: @language,
          url: @url,
          items: @items
        }.to_json options
      end
    end
  end
end