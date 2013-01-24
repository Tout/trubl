require_relative '../../spec_helper'
require 'trapic/client'
require 'webmock'

describe Trapic::API::Conversation do

  it '.retrieve_conversation parses a conversation response correctly' do
    stub_get("https://api.tout.com/api/v1/conversations/iummti53").to_return(:body => fixture("conversation_response.json"))
    conversation = Trapic::Client.new.retrieve_conversation("iummti53")
    expect(conversation).to be_a Trapic::Conversation
    expect(conversation.uid).to eq("iummti53")
    some_request(:get, "/api/v1/conversations/iummti53").should have_been_made
  end

  it '.retrieve_conversation_participants parses conversation participants correctly' do
    stub_get("https://api.tout.com/api/v1/conversations/iummti53/authors").to_return(:body => fixture("conversation_authors_response.json"))
    users = Trapic::Client.new.retrieve_conversation_participants("iummti53")
    expect(users).to be_a Trapic::Users
    expect(users.pagination).to be_a Trapic::Pagination
    users.each do |u|
      expect(u).to be_a Trapic::User
    end
    some_request(:get, "/api/v1/conversations/iummti53/authors").should have_been_made
  end

  it '.retrieve_conversation_touts parses conversation touts correctly' do
    stub_get("https://api.tout.com/api/v1/conversations/iummti53/touts").to_return(:body => fixture("conversation_touts_response.json"))
    touts = Trapic::Client.new.retrieve_conversation_touts("iummti53")
    expect(touts).to be_a Trapic::Touts
    expect(touts.pagination).to be_a Trapic::Pagination
    touts.each do |u|
      expect(u).to be_a Trapic::Tout
    end
    some_request(:get, "/api/v1/conversations/iummti53/touts").should have_been_made
  end

end
