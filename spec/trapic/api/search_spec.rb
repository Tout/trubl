require_relative '../../spec_helper'
require 'retout/client'
require 'webmock'

describe ReTout::API::Search do

  it '.search_hashtags returns hashtag search results properly' do
    stub_get("https://api.tout.com/api/v1/search/hashtags").to_return(:body => fixture("search_hashtags_response.json"))
    hashtags = ReTout::Client.new.search_hashtags("arch")
    expect(hashtags).to be_a ReTout::Hashtags
    expect(hashtags.pagination).to be_a ReTout::Pagination
    hashtags.each do |h|
      expect(h).to be_a ReTout::Hashtag
    end
    some_request(:get, "/api/v1/search/hashtags").should have_been_made
  end

  it '.search_users returns user search results properly' do
    stub_get("https://api.tout.com/api/v1/search/users").to_return(:body => fixture("search_users_response.json"))
    users = ReTout::Client.new.search_users("melissa joan")
    expect(users).to be_a ReTout::Users
    expect(users.pagination).to be_a ReTout::Pagination
    users.each do |u|
      expect(u).to be_a ReTout::User
    end
    some_request(:get, "/api/v1/search/users").should have_been_made
  end

  it '.search_touts returns user search results properly' do
    stub_get("https://api.tout.com/api/v1/search/touts").to_return(:body => fixture("search_touts_response.json"))
    touts = ReTout::Client.new.search_touts("shaq")
    expect(touts).to be_a ReTout::Touts
    expect(touts.pagination).to be_a ReTout::Pagination
    touts.each do |t|
      expect(t).to be_a ReTout::Tout
    end
    some_request(:get, "/api/v1/search/touts").should have_been_made
  end

end
