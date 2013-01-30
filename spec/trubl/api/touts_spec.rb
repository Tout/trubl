require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Touts do

  it '.featured_touts returns a collection of Touts' do
    stub_get("https://api.tout.com/api/v1/featured").to_return(:body => fixture("featured_touts_response.json"))
    touts = Trubl::Client.new.featured_touts()
    expect(touts).to be_a Trubl::Touts
    expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/featured").should have_been_made
  end

  it '.tout_liked_by returns a Collection of Users liking the specified tout' do
    stub_get("https://api.tout.com/api/v1/touts/fhcl57/liked_by").to_return(:body => fixture("touts_liked_by_response.json"))
    users = Trubl::Client.new.tout_liked_by("fhcl57")
    expect(users).to be_a Trubl::Users
    expect(users.pagination).to be_a Trubl::Pagination
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    some_request(:get, "/api/v1/touts/fhcl57/liked_by").should have_been_made
  end

  it '.retrieve_tout returns a Tout object' do
    stub_get("https://api.tout.com/api/v1/touts/fhcl57").to_return(:body => fixture("retrieve_tout.json"))
    tout = Trubl::Client.new.retrieve_tout("fhcl57")
    expect(tout).to be_a Trubl::Tout
    expect(tout.uid).to eq "fhcl57"
    some_request(:get, "/api/v1/touts/fhcl57").should have_been_made
  end

  it '.retrieve_tout_conversation returns the Conversation related to a Tout' do
    stub_get("https://api.tout.com/api/v1/touts/fhcl57/conversation").to_return(:body => fixture("tout_conversation_response.json"))
    conversation = Trubl::Client.new.retrieve_tout_conversation('fhcl57')
    expect(conversation).to be_a Trubl::Conversation
    expect(conversation.uid).to eq('cmbjd3xn')
    some_request(:get, "/api/v1/touts/fhcl57/conversation").should have_been_made
  end

  it '.retrieve_latest returns the latest Touts' do
    stub_get("https://api.tout.com/api/v1/latest").to_return(:body => fixture("latest_touts_response.json"))
    touts = Trubl::Client.new.latest_touts()
    expect(touts).to be_a Trubl::Touts
    expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/latest").should have_been_made
  end

  it '.retrieve_latest returns the latest Touts' do
    stub_get("https://api.tout.com/api/v1/me/updates").to_return(:body => fixture("touts_me_updates_response.json"))
    touts = Trubl::Client.new.retrieve_updates()
    expect(touts).to be_a Trubl::Touts
    expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/me/updates").should have_been_made
  end

  it '.create_tout returns an object representing a newly created Tout' do
    stub_post("https://api.tout.com/api/v1/touts").to_return(:body => fixture('tout.json'))
    file = File.join(File.dirname(__FILE__), '../../fixtures/test.mp4')
    payload = {tout: { data: file, text: 'Some text here'}}
    tout = Trubl::Client.new.create_tout(payload)
    expect(tout).to be_a Trubl::Tout
    expect(tout.uid).to eq "fhcl57"
    some_request(:post, "/api/v1/touts").should have_been_made
  end

  it ".delete_tout returns true on 200 response" do
    stub_delete("https://api.tout.com/api/v1/touts/123456").to_return(:status => 200, :body => "true")
    result = Trubl::Client.new.delete_tout("123456")
    expect(result).to eq(true)
    some_request(:delete, "/api/v1/touts/123456").should have_been_made
  end

  it ".delete_tout returns false on non-200 response" do
    stub_delete("https://api.tout.com/api/v1/touts/234567").to_return(:status => 404, :body => "false")
    result = Trubl::Client.new.delete_tout("234567")
    expect(result).to eq(false)
    some_request(:delete, "/api/v1/touts/234567").should have_been_made
  end

  it ".like_tout returns true on successful response" do
    stub_post("https://api.tout.com/api/v1/touts/fhcl57/likes").to_return(:body => fixture("like_tout_response.json"))
    result = Trubl::Client.new.like_tout("fhcl57")
    expect(result).to eq(true)
    some_request(:post, "/api/v1/touts/fhcl57/likes").should have_been_made
  end

  it ".unlike_tout returns true on successful response" do
    stub_delete("https://api.tout.com/api/v1/touts/fhcl57/likes").to_return(:body => fixture("unlike_tout_response.json"))
    result = Trubl::Client.new.unlike_tout("fhcl57")
    expect(result).to eq(true)
    some_request(:delete, "/api/v1/touts/fhcl57/likes").should have_been_made
  end


end


