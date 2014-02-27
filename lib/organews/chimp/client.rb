require 'mailchimp'
require 'organews/config'

module Organews
  module Chimp
    class Client

      attr_reader :api

      def initialize
        @api = Mailchimp::API.new Organews::Config.vars.chimp_key
      end

      def ping
        @api.helper.ping
      end

    end
  end
end
