require 'thor'

module Organews
  module Chimp
    class Cli < Thor
      include Thor::Actions

      def self.source_root
        File.expand_path("../../../..", __FILE__)
      end

      default_task :help
      class_option :configfile,
        aliases: "-c",
        banner: "PATH",
        default: File.expand_path("config-chimp.yml", Dir.pwd),
        desc: "Path to the configuration file to use"

      desc "check", "checks that config is ok to communicate with mailchimp."
      def check

      end

    end
  end
end
