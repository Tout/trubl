require_relative '../../spec_helper'
require 'retout/client'
require 'webmock'

describe ReTout::API::Hashtags do

  it 'retrieve_hashtag_touts returns Touts::Collection matching a hashtag' do
    stub_get("https://api.tout.com/api/v1/hashtags/ows/touts").to_return(:body => fixture("hashtags_touts_response.json"))
    touts = ReTout::Client.new.retrieve_hashtag_touts("ows")
    expect(touts).to be_a ReTout::Touts
    expect(touts.pagination).to be_a ReTout::Pagination
    touts.each do |u|
      expect(u).to be_a ReTout::Tout
    end
    some_request(:get, "/api/v1/hashtags/ows/touts").should have_been_made
  end

  it 'retrieve_trending_hashtags returns json describing hashtags' do
    stub_get("https://api.tout.com/api/v1/trending_hashtags").to_return(:body => fixture("trending_hashtags_response.json"))
    hashtags = ReTout::Client.new.retrieve_trending_hashtags()
    expect(hashtags).to be_a ReTout::Hashtags
    expect(hashtags.pagination).to be_a ReTout::Pagination
    hashtags.each do |h|
      expect(h).to be_a ReTout::Hashtag
    end
    some_request(:get, "/api/v1/trending_hashtags").should have_been_made
  end

  it 'retrieve_suggested_hashtags returns json describing hashtags' do
    stub_get("https://api.tout.com/api/v1/suggested_hashtags").to_return(:body => fixture("suggested_hashtags_response.json"))
    hashtags = ReTout::Client.new.retrieve_suggested_hashtags("arc", 5)
    expect(hashtags).to be_a ReTout::Hashtags
    hashtags.each do |h|
      expect(h).to be_a ReTout::Hashtag
    end
    some_request(:get, "/api/v1/suggested_hashtags").should have_been_made
  end

end
