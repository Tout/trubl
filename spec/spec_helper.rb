require 'uri'
require 'json'
require 'rspec'
require 'webmock/rspec'
require_relative '../lib/trubl'

class MockResponse
  attr_accessor :body
  def initialize(file)
    @body = fixture(file)
  end
end

def authed_client_for(user)
  
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

def stub_api_get(path, base_uri = "https://api.tout.com/api/v1/")
  stub_get URI.join(base_uri, path).to_s
end

def api_get_request(path, base_uri = "https://api.tout.com/api/v1/") 
  some_request :get, URI.join(base_uri, path).to_s
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
