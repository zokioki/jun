# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jun/version'

Gem::Specification.new do |spec|
  spec.name          = "jun"
  spec.version       = Jun::VERSION
  spec.authors       = ["Zoran"]
  spec.email         = ["zoran1991@gmail.com"]

  spec.summary       = %q{A simple Ruby web framework.}
  spec.description   = %q{A simple web framework inspired by Rails, built with the hopes of learning more about Rails internals in the process.}
  spec.homepage      = "https://github.com/zokioki/jun"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
