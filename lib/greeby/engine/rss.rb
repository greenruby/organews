module Greeby
  module Engine
    class RSS
      attr_accessor :channel, :language, :feeds, :xml

      def initialize(url)
        @feeds = []
        @url = url
        puts "open #{url} as RSS node"
        @xml = Nokogiri::XML open(url)
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

          feed = OpenStruct.new
          feed.title = title
          feed.link = link
          feed.published_at = published_at
          if content.nil?
            threads << Thread.new {
              feed.content = Page.new(link).content
              @feeds << feed
            }
          else
            feed.content = content
            @feeds << feed
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
  end
end