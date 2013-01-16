require 'tout/conversation'
require 'tout/tout'
require 'tout/user'
require 'tout/utils'
require_relative '../spec_helper'

describe Tout::Utils do

  it "provides usable Tout::Utils::Collection objects with touts" do
    collection =  Tout::Utils::Collection.new.from_response(response_fixture("touts_search_results.json"))
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    collection.touts.each do |t|
      expect(t).to be_a Tout::Touts::Tout
    end
    expect(collection.users).to be nil
  end

  it "provides usable Tout::Utils::Collection objects with users" do
    collection =  Tout::Utils::Collection.new.from_response(response_fixture("users_search_results.json"))
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    collection.users.each do |u|
      expect(u).to be_a Tout::User
    end
    expect(collection.touts).to be nil
  end

  it "gets a Tout::Conversation from a conversation response" do
    conversation = Tout::Utils.conversation_from_response(response_fixture("conversation_response.json"))
    expect(conversation).to be_a Tout::Conversation
    expect(conversation.uid).to eq("iummti53")
  end

  it "builds a handy uri" do
    uri = Tout::Utils.uri_builder("https://api.tout.com/", "api/", "v1/", "users")
    expect(uri).to eq("https://api.tout.com/api/v1/users")
  end

  it "parses data into Pagination objects correctly" do
    pagination = Tout::Utils.pagination_from_response(response_fixture("touts_search_results.json"))
    expect(pagination.order).to eq(nil)
    expect(pagination.per_page).to eq(5)
    expect(pagination.page).to eq(5)
    expect(pagination.total_entries).to eq(867)
  end

  it "parses data into a Tout object correctly" do
    tout = Tout::Utils.tout_from_response(response_fixture("tout.json"))
    expect(tout).to be_a Tout::Touts::Tout
    expect(tout.uid).to eq("fhcl57")
  end

  it "parses data into Tout objects correctly" do
    touts = Tout::Utils.touts_from_response(response_fixture("touts_search_results.json"))
    expect(touts).to be_a Array
    touts.each do |t|
      expect(t).to be_a Tout::Touts::Tout
    end
  end

  it "parses data into a User object correctly" do
    user = Tout::Utils.user_from_response(response_fixture("user.json"))
    expect(user).to be_a Tout::User
    expect(user.uid).to eq("karmin")
  end

  it "parses data into User objects correctly" do
    users = Tout::Utils.users_from_response(response_fixture("users_search_results.json"))
    expect(users).to be_a Array
    users.each do |u|
      expect(u).to be_a Tout::User
    end
  end

end