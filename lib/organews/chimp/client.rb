require 'mailchimp'
require 'organews/config'

module Organews
  module Chimp
    class Client

      attr_reader :api

      def initialize
        @api = Mailchimp::API.new Organews::Config.vars.chimp_key
        @listid = Organews::Config.vars.chimp_list
      end

      def ping
        @api.helper.ping
      end

      def lists
        @api.lists.list['data'].reduce([]) do |a,e|
          a << { id: e['id'], name: e['name'], members: e['stats']['member_count'] }
          a
        end
      end

      def templates
        @api.templates.list['user'].reduce([]) do |a,e|
          a << { id: e['id'], name: e['name']}
          a
        end
      end

      def template_del(id)
        @api.templates.del(id)
      end

      def campain_new(html, txt)
      end

    end
  end
end
