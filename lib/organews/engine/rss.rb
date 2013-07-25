require 'nokogiri'
require 'organews/engine/page'

module Organews
  module Engine
    class RSS
      attr_accessor :channel, :language, :items, :xml

      def initialize(url)
        @items = []
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

          item = {}
          item['title'] = title
          item['link'] = link
          item['published_at'] = published_at
          if content.nil?
            threads << Thread.new {
              item['content'] = Page.new(link).content
              @items << item
            }
          else
            item['content'] = content
            @items << item
          end
        end
        threads.each { |t| t.join }
      end

      def to_json(options = {})
        {
          channel: @channel,
          language: @language,
          items: @items
        }.to_json options
      end
    end
  end
end