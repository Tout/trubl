# encoding: utf-8
require File.expand_path('../lib/trubl/version', __FILE__)

Gem::Specification.new do |spec|
  spec.add_dependency 'json', '~> 1.7.7'
  spec.add_dependency 'yajl-ruby', '~> 1.1.0'
  spec.add_dependency 'httparty', '~> 0.9.0'
  spec.add_dependency 'faraday', '>= 0.8.4'
  spec.add_dependency 'typhoeus'
  spec.add_dependency 'activesupport', '>= 3.2.11'
  spec.add_dependency 'oauth2', '~> 0.9.1'
  spec.add_dependency 'hashie', '~> 2.0.2'
  spec.add_dependency 'rake'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-debugger'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-encoding-matchers'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'webmock'

  spec.authors = ["Aaron Terrell", "Aaron Glenn", "Felix Roeser"]
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
