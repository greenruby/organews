require 'readability'

module Greeby
  module Engine
    class Page
      def initialize(url)
        p "open #{url[0..50]} as web page"
        @url = url
        begin
          @html = open(url).read
          parse
        rescue Exception => e
          puts "Error in parsing #{url[0..50]} : #{e.message}"
        end
      end

      def digest
        Digest::MD5.hexdigest @url
      end

      def parse
        @content = Readability::Document.new(@html).content
      end

      def content
        @content
      end
    end
  end
end