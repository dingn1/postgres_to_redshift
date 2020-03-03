# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pg_to_redshift/version"

Gem::Specification.new do |spec|
  spec.name          = "pg_to_redshift"
  spec.version       = PgToRedshift::VERSION
  spec.authors       = ["Ning Ding"]
  spec.email         = ["yanwding@gmail.com"]
  spec.summary       = "Load PG databases into Amazon Redshift"
  spec.description   = "Load PG databases into Amazon Redshift. It's designed to work on any *nix/BSD hosts."
  spec.homepage      = "https://github.com/dingn1/pg_to_redshift"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_dependency "aws-sdk", "~> 3"
  spec.add_dependency "pg", "~> 0.18.4"
end
