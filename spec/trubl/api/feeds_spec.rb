require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Feeds do

  it '.retrieve_feed returns a feed' do
    stub_get("https://api.tout.com/api/v1/feeds/s43x2f").to_return(:body => fixture("feed_response.json"))
    playlist = Trubl::Client.new.retrieve_feed('s43x2f')
    expect(playlist).to be_a Trubl::Feed
    some_request(:get, "/feeds/s43x2f").should have_been_made
  end

  # todo: the fixture is not an authentic feed response, add one please
  it '.retrieve_feed_touts returns touts included in a feed' do
    stub_get("https://api.tout.com/api/v1/feeds/s43x2f/touts").to_return(:body => fixture("feed_touts_response.json"))
    touts = Trubl::Client.new.retrieve_feed_touts('s43x2f')
    expect(touts).to be_a Trubl::Touts
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/feeds/s43x2f/touts").should have_been_made
  end

  it '.retrieve_feeds_touts_json returns touts included in a feeds' do
    stub_get("https://api.tout.com/api/v1/feeds/s43x2f/touts.json").to_return(:body => fixture("feed_touts_response.json"))
    touts = Trubl::Client.new.retrieve_feed_touts_json('s43x2f')
    expect(touts).to be_a Trubl::Touts
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/feeds/s43x2f/touts.json").should have_been_made
  end
end
