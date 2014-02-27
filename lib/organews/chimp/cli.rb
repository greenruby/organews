require 'thor'
require 'organews/config'
require 'organews/chimp/client'

module Organews
  module Chimp
    class Cli < Thor
      include Thor::Actions

      default_task :help
      class_option :configfile,
        aliases: "-c",
        banner: "PATH",
        default: File.expand_path("config.yml", Dir.pwd),
        desc: "Path to the configuration file to use"

      desc "check", "checks that config is ok to communicate with mailchimp."
      def check
        Organews::Config.load options[:configfile]
        mailchimp = Organews::Chimp::Client.new
        begin
          mailchimp.ping
          say set_color("All good.", :green, :bold)
        rescue Exception => e
          say set_color("*** Error ***", :red, :bold)
          say set_color(e.message, :red)
        end
      end

    end
  end
end
