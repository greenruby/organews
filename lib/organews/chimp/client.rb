require 'mailchimp'

module Organews
  module Chimp
    class Client

      def initialize
        @mailchimp = Mailchimp::Api.new( api_key: Organews::Config.vars.chimp_key )
      end

    end
  end
end
