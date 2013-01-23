require 'json'
require 'rspec'
require 'webmock/rspec'
require_relative '../lib/retout'

class MockResponse
  attr_accessor :body
  def initialize(file)
    @body = fixture(file)
  end
end

def stub_delete(uri)
  request_stub(:delete, uri)
end

def stub_post(uri)
  request_stub(:post, uri)
end

def stub_get(uri)
  request_stub(:get, uri)
end

def stub_put(uri)
  request_stub(:put, uri)
end

def request_stub(method, uri)
  stub_request(method, /.*?#{uri}.*?/)
end

def some_request(method, uri)
  a_request(method, /.*?#{uri}.*?/)
end

def fixture(file)
  File.read(File.expand_path('../fixtures/', __FILE__) +'/' + file)
end

def json_fixture(file)
  JSON.parse(fixture(file))
end

def response_fixture(file)
  MockResponse.new(file)
end
