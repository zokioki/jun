# frozen_string_literal: true

require_relative "lib/jun/version"

Gem::Specification.new do |spec|
  spec.name = "jun"
  spec.version = Jun::VERSION
  spec.authors = ["Zoran"]

  spec.summary = "A simple Ruby web framework."
  spec.description = "A simple web framework inspired by Rails. Not meant for production use."
  spec.homepage = "https://github.com/zokioki/jun"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir["*.{md,txt}", "lib/**/*"]

  spec.bindir = "exe"
  spec.executables = ["jun"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rack", "~> 2.2"
  spec.add_runtime_dependency "tilt", "~> 2.0"
  spec.add_runtime_dependency "sqlite3", "~> 1.4"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "pry", "~> 0.14"
end
