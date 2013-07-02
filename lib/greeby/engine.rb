require 'nokogiri'
require 'open-uri'
require 'digest/md5'
require 'json'

module Greeby
  module Engine
    class RSS
      attr_accessor :channel, :language, :feeds

      class Feed
        attr_accessor :title, :link, :published_at, :content

        def to_json(options = {})
          { 
            title: title, 
            link: link, 
            published_at: published_at,
            content: content
          }.to_json options
        end
      end

      def initialize(url)
        @feeds = []
        @url = url
        puts "open #{url} as RSS node"
        @xml = Nokogiri::XML open(url)

        parse
      end

      def digest
        Digest::MD5.hexdigest @url
      end

      def parse
        @channel = @xml.xpath('//channel/title').inner_text
        @language = @xml.xpath('//channel/language').inner_text

        threads = []
        @xml.xpath('//item').each do |i|
          title = i.xpath('title').inner_text
          link = i.xpath('link').inner_text
          published_at = i.xpath('pubDate').inner_text
          # If xml does not declare the content in xmlns will raise exception
          begin
            content = i.xpath('content:encoded').inner_text
          rescue
            content = nil
          end

          feed = Feed.new
          feed.title = title
          feed.link = link
          feed.published_at = published_at
          if content.nil?
            threads << Thread.new {
              feed.content = Page.new(link).content
              @feeds.push feed
            }
          else
            feed.content = content
            @feeds.push feed
          end
        end
        threads.each { |t| t.join }
      end

      def to_json(options = {})
        {
          channel: @channel,
          language: @language,
          feeds: @feeds
        }.to_json options
      end
    end

    class Page
      def initialize(url)
        p "open #{url[0..50]} as web page"
        @url = url
        @html = Nokogiri::HTML open(url)
        parse
      end

      def digest
        Digest::MD5.hexdigest @url
      end

      # TODO: implement this
      def parse
        @content = @html.to_s
      end

      def content
        @content
      end
    end
  end
end

# e = Greeby::Engine::RSS.new 'http://www.inside.com.tw/feed'
# e = Greeby::Engine::RSS.new 'https://news.ycombinator.com/rss'
# e.to_json