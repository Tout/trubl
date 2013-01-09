require 'rspec'
require 'webmock/rspec'

def stub_post(path, endpoint='')
  stub_request(:post, endpoint + path)
end

def fixture(file)
  File.new(File.expand_path('../fixtures/', __FILE__) +'/' + file)
end