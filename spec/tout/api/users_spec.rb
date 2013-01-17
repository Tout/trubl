require_relative '../../spec_helper'
require 'tout/client'
require 'webmock'

describe Tout::API::Users do

  it '.retrieve_user returns a Tout::User' do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = Tout::Client.new.retrieve_user("karmin")
    expect(user).to be_a Tout::User
    expect(user.uid).to eq("karmin")
    some_request(:get, "/api/v1/users/karmin").should have_been_made
  end

  it '.retrieve_user_likes returns a Collection of Touts liked by the specified user' do
    stub_get("https://api.tout.com/api/v1/users/karmin/likes").to_return(:body => fixture("touts_liked_by_user_response.json"))
    collection = Tout::Client.new.retrieve_user_likes("karmin")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.users).to be nil
    collection.touts.each do |u|
      expect(u).to be_a Tout::Touts::Tout
    end
    some_request(:get, "/api/v1/users/karmin/likes").should have_been_made
  end

  it '.retrieve_user_touts returns a Collection of Touts created by the specified user' do
    stub_get("https://api.tout.com/api/v1/users/teamtout/touts").to_return(:body => fixture("user_touts_response.json"))
    collection = Tout::Client.new.retrieve_user_touts("teamtout")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.users).to be nil
    collection.touts.each do |u|
      expect(u).to be_a Tout::Touts::Tout
    end
    some_request(:get, "/api/v1/users/teamtout/touts").should have_been_made
  end

  it '.retrieve_user_followers returns the Users following the specified user' do
    stub_get("https://api.tout.com/api/v1/users/teamtout/followers").to_return(:body => fixture("user_followers.json"))
    collection = Tout::Client.new.retrieve_user_followers("teamtout")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.touts).to be nil
    collection.users.each do |u|
      expect(u).to be_a Tout::User
    end
    some_request(:get, "/api/v1/users/teamtout/followers").should have_been_made
  end

end
