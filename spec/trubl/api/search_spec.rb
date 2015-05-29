require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Search do

  it '.search_hashtags returns hashtag search results properly' do
    stub_get("https://api.tout.com/api/v1/search/hashtags").to_return(:body => fixture("search_hashtags_response.json"))
    hashtags = Trubl::Client.new.search_hashtags("arch")
    expect(hashtags).to be_a Trubl::Hashtags
    #expect(hashtags.pagination).to be_a Trubl::Pagination
    hashtags.each do |h|
      expect(h).to be_a Trubl::Hashtag
    end
    some_request(:get, "/api/v1/search/hashtags").should have_been_made
  end

  it '.search_users returns user search results properly' do
    stub_get("https://api.tout.com/api/v1/search/users").to_return(:body => fixture("search_users_response.json"))
    users = Trubl::Client.new.search_users("melissa joan")
    expect(users).to be_a Trubl::Users
    #expect(users.pagination).to be_a Trubl::Pagination
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    some_request(:get, "/api/v1/search/users").should have_been_made
  end

  it '.search_touts returns user search results properly' do
    stub_get("https://api.tout.com/api/v1/search/touts").to_return(:body => fixture("search_touts_response.json"))
    touts = Trubl::Client.new.search_touts("shaq")
    expect(touts).to be_a Trubl::Touts
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |t|
      expect(t).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/search/touts").should have_been_made
  end

  it '.search_touts_json returns user search results properly' do
    stub_get("https://api.tout.com/api/v1/search/touts.json").to_return(:body => fixture("search_touts_response.json"))
    touts = Trubl::Client.new.search_touts_json("shaq")
    expect(touts).to be_a Trubl::Touts
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |t|
      expect(t).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/search/touts").should have_been_made
  end

end
