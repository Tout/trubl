require_relative '../../spec_helper'
require 'tout/client'
require 'webmock'

describe Tout::API::Hashtags do

  it 'retrieve_hashtag_touts returns Touts::Collection matching a hashtag' do
    stub_get("https://api.tout.com/api/v1/hashtags/ows/touts").to_return(:body => fixture("hashtags_touts_response.json"))
    collection = Tout::Client.new.retrieve_hashtag_touts("ows")
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.users).to be nil
    collection.touts.each do |u|
      expect(u).to be_a Tout::Touts::Tout
    end
    some_request(:get, "/api/v1/hashtags/ows/touts").should have_been_made
  end

  it 'retrieve_trending_hashtags returns json describing hashtags' do
    stub_get("https://api.tout.com/api/v1/trending_hashtags").to_return(:body => fixture("trending_hashtags_response.json"))
    collection = Tout::Client.new.retrieve_trending_hashtags()
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be_a Tout::Utils::Pagination
    expect(collection.hashtags).to be_a Array
    collection.hashtags.each do |h|
      expect(h).to be_a Hash
    end
    some_request(:get, "/api/v1/trending_hashtags").should have_been_made
  end

  it 'retrieve_suggested_hashtags returns json describing hashtags' do
    stub_get("https://api.tout.com/api/v1/suggested_hashtags").to_return(:body => fixture("suggested_hashtags_response.json"))
    collection = Tout::Client.new.retrieve_suggested_hashtags("arc", 5)
    expect(collection).to be_a Tout::Utils::Collection
    expect(collection.pagination).to be nil
    expect(collection.hashtags).to be_a Array
    collection.hashtags.each do |h|
      expect(h).to be_a Hash
    end
    some_request(:get, "/api/v1/suggested_hashtags").should have_been_made
  end

end
