require_relative '../../spec_helper'
require 'tout/client'
require 'webmock'

describe Tout::API::Conversation do

  it 'parses a conversation response correctly' do
    stub_get("https://api.tout.com/api/v1/conversations/iummti53").to_return(:body => fixture("conversation_response.json"))
    conversation = Tout::Client.new.retrieve_conversation("iummti53")
    expect(conversation).to be_a Tout::Conversation
    expect(conversation.uid).to eq("iummti53")
    some_request(:get, "/api/v1/conversations/iummti53").should have_been_made
  end

  it 'parses a conversation participants correctly' do
    stub_get("https://api.tout.com/api/v1/conversations/iummti53/authors").to_return(:body => fixture("conversation_authors_response.json"))
    collection = Tout::Client.new.retrieve_conversation_participants("iummti53")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.touts).to be nil
    collection.users.each do |u|
      expect(u).to be_a Tout::User
    end
    some_request(:get, "/api/v1/conversations/iummti53/authors").should have_been_made
  end

  it 'parses a conversation touts correctly' do
    stub_get("https://api.tout.com/api/v1/conversations/iummti53/touts").to_return(:body => fixture("conversation_touts_response.json"))
    collection = Tout::Client.new.retrieve_conversation_touts("iummti53")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.users).to be nil
    collection.touts.each do |u|
      expect(u).to be_a Tout::Touts::Tout
    end
    some_request(:get, "/api/v1/conversations/iummti53/touts").should have_been_made
  end

end
