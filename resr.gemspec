# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "resr/version"

Gem::Specification.new do |spec|
  spec.name          = "resr"
  spec.version       = Resr::VERSION
  spec.authors       = ["Aaron Rustad"]
  spec.email         = ["arustad@anassina.com"]

  spec.summary       = %q{Basic reservation system for Slack}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   << 'resr'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"

  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "slack-ruby-client"
end
