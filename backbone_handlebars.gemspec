# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backbone_handlebars/version'

Gem::Specification.new do |gem|
  gem.name          = "backbone_handlebars"
  gem.version       = BackboneHandlebars::VERSION
  gem.authors       = ["Blake Williams"]
  gem.email         = ["blake@blakewilliams.me"]
  gem.summary       = %q{Backbone and Handlebars for Rails 3.1+}
  gem.homepage      = "http://github.com/BlakeWilliams/backbone_handlebars"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "execjs"
  gem.add_dependency "sprockets"
  gem.add_dependency "tilt"
end
