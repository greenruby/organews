require "yaml"
require "organews/utils"

module Organews
  module Config
    include Utils
    extend self

    def load(configfile)
      @__configfile = configfile
    end

    def vars
      unless File.exist?(configfile)
        raise RuntimeError, "Missing configuration file, run `organews init` or create a config.yml file."
      end
      @__config ||= to_ostruct(YAML::load_file(configfile))
      @__config
    end

    def configfile
      @__configfile || ""
    end

    def reset
      remove_instance_variable :@__configfile if instance_variable_get :@__configfile
      remove_instance_variable :@__config if instance_variable_get :@__config
    end

  end
end
