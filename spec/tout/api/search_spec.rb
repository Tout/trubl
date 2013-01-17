require_relative '../../spec_helper'
require 'tout/client'
require 'webmock'

describe Tout::API::Search do

  it '.search_hashtags returns hashtag search results properly' do
    stub_get("https://api.tout.com/api/v1/search/hashtags").to_return(:body => fixture("search_hashtags_response.json"))
    collection = Tout::Client.new.search_hashtags("arch")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.hashtags).to be_a Array
    collection.hashtags.each do |h|
      expect(h).to be_a Hash
    end
    expect(collection.touts).to be nil
    expect(collection.users).to be nil
    some_request(:get, "/api/v1/search/hashtags").should have_been_made
  end

  it '.search_users returns user search results properly' do
    stub_get("https://api.tout.com/api/v1/search/users").to_return(:body => fixture("search_users_response.json"))
    collection = Tout::Client.new.search_users("melissa joan")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.users).to be_a Array
    collection.users.each do |u|
      expect(u).to be_a Tout::User
    end
    expect(collection.touts).to be nil
    expect(collection.hashtags).to be nil
    some_request(:get, "/api/v1/search/users").should have_been_made
  end

  it '.search_touts returns user search results properly' do
    stub_get("https://api.tout.com/api/v1/search/touts").to_return(:body => fixture("search_touts_response.json"))
    collection = Tout::Client.new.search_touts("shaq")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.touts).to be_a Array
    collection.touts.each do |t|
      expect(t).to be_a Tout::Touts::Tout
    end
    expect(collection.users).to be nil
    expect(collection.hashtags).to be nil
    some_request(:get, "/api/v1/search/touts").should have_been_made
  end

end
