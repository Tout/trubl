require_relative '../../spec_helper'
require 'retout/client'
require 'webmock'

describe ReTout::API::Conversation do

  it '.retrieve_conversation parses a conversation response correctly' do
    stub_get("https://api.tout.com/api/v1/conversations/iummti53").to_return(:body => fixture("conversation_response.json"))
    conversation = ReTout::Client.new.retrieve_conversation("iummti53")
    expect(conversation).to be_a ReTout::Conversation
    expect(conversation.uid).to eq("iummti53")
    some_request(:get, "/api/v1/conversations/iummti53").should have_been_made
  end

  it '.retrieve_conversation_participants parses conversation participants correctly' do
    stub_get("https://api.tout.com/api/v1/conversations/iummti53/authors").to_return(:body => fixture("conversation_authors_response.json"))
    collection = ReTout::Client.new.retrieve_conversation_participants("iummti53")
    expect(collection).to be_a ReTout::Utils::Collection
    expect(collection.pagination).to be_a ReTout::Utils::Pagination
    expect(collection.touts).to be nil
    collection.users.each do |u|
      expect(u).to be_a ReTout::User
    end
    some_request(:get, "/api/v1/conversations/iummti53/authors").should have_been_made
  end

  it '.retrieve_conversation_touts parses conversation touts correctly' do
    stub_get("https://api.tout.com/api/v1/conversations/iummti53/touts").to_return(:body => fixture("conversation_touts_response.json"))
    collection = ReTout::Client.new.retrieve_conversation_touts("iummti53")
    expect(collection).to be_a ReTout::Utils::Collection
    expect(collection.pagination).to be_a ReTout::Utils::Pagination
    expect(collection.users).to be nil
    collection.touts.each do |u|
      expect(u).to be_a ReTout::Tout
    end
    some_request(:get, "/api/v1/conversations/iummti53/touts").should have_been_made
  end

end
