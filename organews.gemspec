# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'organews/version'

Gem::Specification.new do |spec|
  spec.name          = "organews"
  spec.version       = Organews::VERSION
  spec.authors       = ["mose"]
  spec.email         = ["mose@mose.com"]
  spec.summary       = %q{A tool to organize a small amount of news.}
  spec.description   = %q{A tool to organize a small amount of news, for news letter publication.}
  spec.homepage      = "https://github.com/greenruby/organews"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["exec/organews"]
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "grape"
  spec.add_dependency "sequel"
  spec.add_dependency "goliath"
  spec.add_dependency "sqlite3"
  spec.add_dependency "rack-fiber_pool"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "inch"
  spec.add_development_dependency "coveralls"
end
