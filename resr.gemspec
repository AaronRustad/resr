# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "resr/version"

Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY
  spec.name          = "resr"
  spec.version       = Resr::VERSION
  spec.summary       = "Basic reservation system for Slack"
  spec.description   = "Resr is a simple application that uses a Slack channel and its topic to manage ownership of staging servers."

  spec.license       = "MIT"

  spec.authors       = ["Aaron Rustad"]
  spec.email         = ["arustad@anassina.com"]
  spec.homepage      = 'https://github.com/AaronRustad/resr'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   << 'resr'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard", "~> 2.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7"

  spec.add_runtime_dependency "thor", "~> 0.2"
  spec.add_runtime_dependency "slack-ruby-client", "~> 0.10"
end
