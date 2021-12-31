# frozen_string_literal: true

require_relative "lib/jun/version"

Gem::Specification.new do |spec|
  spec.name = "jun"
  spec.version = Jun::VERSION
  spec.authors = ["Zoran"]
  spec.email = ["zspesic@gmail.com"]

  spec.summary = "A simple Ruby web framework."
  spec.description = "A simple web framework inspired by Rails."
  spec.homepage = "https://github.com/zokioki/jun"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "sqlite3"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
end
