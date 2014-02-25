require 'mailchimp'
require 'organews/config'

module Organews
  module Chimp
    class Client

      def initialize
        @mailchimp = Mailchimp::API.new Organews::Config.vars.chimp_key
      end

      def ping
        @mailchimp.helper.ping
      end

    end
  end
end
