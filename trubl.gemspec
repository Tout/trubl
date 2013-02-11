# encoding: utf-8
require File.expand_path('../lib/trubl/version', __FILE__)

Gem::Specification.new do |spec|
  spec.add_dependency 'json'
  spec.add_dependency 'httparty', '~> 0.9.0'
  spec.add_dependency 'faraday', '>= 0.8.4'
  spec.add_dependency 'activesupport', '>= 3.2.11'
  spec.add_dependency 'oauth2'
  spec.add_dependency 'hashie'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-debugger'
  spec.add_development_dependency 'simplecov'
  spec.authors = ["Aaron Terrell", "Aaron Glenn"]
  spec.description = %q{A Ruby interface to the Tout API.}
  spec.email = ['help@tout.com']
  spec.files = %w(.yardopts LICENSE.md README.md Rakefile trubl.gemspec)
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("spec/**/*")
  spec.homepage = 'http://developer.tout.com/'
  spec.licenses = ['MIT']
  spec.name = 'trubl'
  spec.require_paths = ['lib']
  spec.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  spec.summary = spec.description
  spec.test_files = Dir.glob("spec/**/*")
  spec.version = Trubl::Version
end
