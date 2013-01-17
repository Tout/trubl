require_relative '../../spec_helper'
require 'tout/client'
require 'webmock'

describe Tout::API::Touts do

  it '.featured_touts returns a collection of Touts' do
    stub_get("https://api.tout.com/api/v1/featured").to_return(:body => fixture("featured_touts_response.json"))
    collection = Tout::Client.new.featured_touts()
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.users).to be nil
    collection.touts.each do |u|
      expect(u).to be_a Tout::Touts::Tout
    end
    some_request(:get, "/api/v1/featured").should have_been_made
  end

  it '.tout_liked_by returns a Collection of Users liking the specified tout' do
    stub_get("https://api.tout.com/api/v1/touts/fhcl57/liked_by").to_return(:body => fixture("touts_liked_by_response.json"))
    collection = Tout::Client.new.tout_liked_by("fhcl57")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.touts).to be nil
    collection.users.each do |u|
      expect(u).to be_a Tout::User
    end
    some_request(:get, "/api/v1/touts/fhcl57/liked_by").should have_been_made
  end

  it '.retrieve_tout returns a Tout object' do
    stub_get("https://api.tout.com/api/v1/touts/fhcl57").to_return(:body => fixture("retrieve_tout.json"))
    tout = Tout::Client.new.retrieve_tout("fhcl57")
    expect(tout).to be_a Tout::Touts::Tout
    expect(tout.uid).to eq "fhcl57"
    some_request(:get, "/api/v1/touts/fhcl57").should have_been_made
  end

  it '.retrieve_tout_conversation returns the Conversation related to a Tout' do
    stub_get("https://api.tout.com/api/v1/touts/fhcl57/conversation").to_return(:body => fixture("tout_conversation_response.json"))
    conversation = Tout::Client.new.retrieve_tout_conversation('fhcl57')
    expect(conversation).to be_a Tout::Conversation
    expect(conversation.uid).to eq('cmbjd3xn')
    some_request(:get, "/api/v1/touts/fhcl57/conversation").should have_been_made
  end

  it '.retrieve_latest returns the latest Touts' do
    stub_get("https://api.tout.com/api/v1/latest").to_return(:body => fixture("latest_touts_response.json"))
    collection = Tout::Client.new.latest_touts()
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.users).to be nil
    collection.touts.each do |u|
      expect(u).to be_a Tout::Touts::Tout
    end
    some_request(:get, "/api/v1/latest").should have_been_made
  end

end


