require "organews/utils"

module Organews
  module Config
    include Utils
    extend self

    def load(configfile)
      @__configfile = configfile
    end

    def vars
      unless File.exists? configfile
        raise RuntimeError, "Missing configuration file, run `organews init` or create a config.yml file."
      end
      @__config ||= to_ostruct(YAML::load_file(configfile))
      @__config
    end

    def configfile
      @__configfile
    end

  end
end
