require_relative "../spec_helper"
require "trubl/client"

describe Trubl::Client do

  let(:client) { Trubl::Client.new() }

  describe '#new' do
    subject { client }
    it { should be_a Trubl::Client }
  end

  describe ".auth" do
    it "stores access_token" do
      body = "client_id=&client_secret=&grant_type=client_credentials"
      headers = {'Accept'=>'application/json', 'Authorization'=>'Bearer', 'Connection'=>'keep-alive'}
      stub_post("https://www.tout.com/oauth/token").with(body: body, headers: headers).to_return(body: fixture("client1_auth_resp.json"))
      client.client_auth()
      expect(client.access_token).to eq "6bffd46fca32a9dc640a7f2284edd55b5175d59323923f984b92ee5ec6a0a9e4"
    end
  end

  describe ".credentials" do
    it "returns a hash of creds" do
      body = "client_id=client_id&client_secret=client_sekrit&grant_type=client_credentials"
      headers = {'Accept'=>'application/json', 'Authorization'=>'Bearer', 'Connection'=>'keep-alive'}
      stub_post("https://www.tout.com/oauth/token").with(body: body, headers: headers).to_return(body: fixture("client1_auth_resp.json"))
      client = Trubl::Client.new("client_id", "client_sekrit")
      client.client_auth()
      expect(client.credentials).to eq({client_id:"client_id", client_secret:"client_sekrit", access_token:"6bffd46fca32a9dc640a7f2284edd55b5175d59323923f984b92ee5ec6a0a9e4"})

    end
  end

  describe ".api_uri_root" do
    let(:port)       { nil }
    let(:host)       { nil }
    let(:uri_scheme) { nil }
    subject { Trubl::Client.new(:fake_id, :fake_secret, nil, uri_port: port, uri_host: host, uri_scheme: uri_scheme) }

    its(:api_uri_root) { should == 'https://api.tout.com/api/v1/' }

    context 'setting a port' do
      let(:port) { 3000 }
      its(:api_uri_root) { should == 'https://api.tout.com:3000/api/v1/' }
    end

    context 'setting a host and protocol' do
      let(:host)         { 'localhost' }
      let(:uri_scheme)   { 'http' }
      its(:api_uri_root) { should == 'http://localhost/api/v1/' }
    end
  end

  describe ".delete" do
    it "processes a delete" do
      path = "toutitout"
      stub_delete(path).to_return(:status => 200, :body => "", :headers => {})
      client.delete(path)
      some_request(:delete, path).should have_been_made
    end
  end

  describe ".post" do
    it "processes a post" do
      path = "toutitout"
      stub_post(path).to_return(:status => 200, :body => "", :headers => {})
      client.post(path)
      some_request(:post, path).should have_been_made
    end
  end

  describe ".get" do
    it "processes a get" do
      path = "toutitout"
      stub_get(path).to_return(:status => 200, :body => "", :headers => {})
      client.get(path)
      some_request(:get, path).should have_been_made
    end
  end

  describe ".put" do
    it "processes a put" do
      path = "toutitout"
      stub_put(path).to_return(:status => 200, :body => "", :headers => {})
      client.put(path)
      some_request(:put, path).should have_been_made
    end
  end

  describe ".multi_request" do
    # See https://github.com/typhoeus/typhoeus/issues/278
    # there might be a bug then requests.size > max_concurrency while running specs
    let(:uids)     { 9.times.collect { |i| "random-user-#{i}" } }
    let(:requests) { uids.collect { |uid| { path: "/users/#{uid}" } } }
    let(:method)   { :get }
    let(:multi_request) { client.multi_request(method, requests)}
    subject { multi_request }

    context 'with a valid request method' do
      before do
        (requests || []).each_with_index do |request, index|
          uid = request[:path].split('/').last
          request_stub(method, request[:path]).to_return(status: 200 + index, body: "fake-#{uid}", headers: {})
        end
      end

      its(:size) { should == uids.size }

      describe 'response bodies' do
        subject { multi_request.map(&:body).sort }
        it { should == uids.collect { |u| "fake-#{u}"} }
      end

      describe 'response status codes' do
        subject do
          multi_request.map(&:code).sort
        end
        it { should == uids.size.times.collect { |i| 200+i } }
      end

      context 'with a blank request list' do
        let(:requests) { nil }
        it { should == [] }
      end

    end

    context 'with an invalid request method' do
      let(:method) { :unsupported }
      it { should == [] }
    end
  end

end
