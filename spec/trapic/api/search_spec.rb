require_relative '../../spec_helper'
require 'trapic/client'
require 'webmock'

describe Trapic::API::Search do

  it '.search_hashtags returns hashtag search results properly' do
    stub_get("https://api.tout.com/api/v1/search/hashtags").to_return(:body => fixture("search_hashtags_response.json"))
    hashtags = Trapic::Client.new.search_hashtags("arch")
    expect(hashtags).to be_a Trapic::Hashtags
    expect(hashtags.pagination).to be_a Trapic::Pagination
    hashtags.each do |h|
      expect(h).to be_a Trapic::Hashtag
    end
    some_request(:get, "/api/v1/search/hashtags").should have_been_made
  end

  it '.search_users returns user search results properly' do
    stub_get("https://api.tout.com/api/v1/search/users").to_return(:body => fixture("search_users_response.json"))
    users = Trapic::Client.new.search_users("melissa joan")
    expect(users).to be_a Trapic::Users
    expect(users.pagination).to be_a Trapic::Pagination
    users.each do |u|
      expect(u).to be_a Trapic::User
    end
    some_request(:get, "/api/v1/search/users").should have_been_made
  end

  it '.search_touts returns user search results properly' do
    stub_get("https://api.tout.com/api/v1/search/touts").to_return(:body => fixture("search_touts_response.json"))
    touts = Trapic::Client.new.search_touts("shaq")
    expect(touts).to be_a Trapic::Touts
    expect(touts.pagination).to be_a Trapic::Pagination
    touts.each do |t|
      expect(t).to be_a Trapic::Tout
    end
    some_request(:get, "/api/v1/search/touts").should have_been_made
  end

end
