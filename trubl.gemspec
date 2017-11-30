# encoding: utf-8
require File.expand_path('../lib/trubl/version', __FILE__)

Gem::Specification.new do |spec|
  spec.add_dependency 'json', '~> 1.8.6'
  spec.add_dependency 'httparty', '~> 0.15.6'
  spec.add_dependency 'httmultiparty', '~> 0.3.16'
  spec.add_dependency 'faraday', '~> 0.12.2'
  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'oauth2', '~> 1.0'
  spec.add_dependency 'hashie', '~> 3.5.6'
  spec.add_dependency 'rake'

  if RUBY_ENGINE == 'ruby'
    spec.add_dependency 'typhoeus', '0.6.8'
    spec.add_dependency 'yajl-ruby'
  end

  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'pry'
  #commented because of Travis build failures (for some reason it could not run Bundler successfully and failed with "An error occurred while installing debugger (1.5.0), and Bundler cannot continue")
  #spec.add_development_dependency 'pry-debugger', if RUBY_ENGINE == 'ruby'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'rspec-encoding-matchers'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'webmock', '~> 1.24'

  spec.authors = ["Aaron Terrell", "Aaron Glenn", "Felix Roeser", "Will Bryant"]
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
