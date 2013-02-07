require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Channel do

  it '.retrieve_channel parses a channel response correctly' do
    stub_get("https://api.tout.com/api/v1/channel/new-york-fashion-week").to_return(:body => fixture("channel_response.json"))
    channel = Trubl::Client.new.retrieve_channel("new-york-fasion-week")
    expect(channel).to be_a Trubl::Channel
    expect(channel.uid).to eq("new-york-fashion-week")
    some_request(:get, "/api/v1/channel/new-york-fashion-week").should have_been_made
  end

  it '.retrieve_channel_contributors parses channel contributors correctly' do
    stub_get("https://api.tout.com/api/v1/channels/new-york-fashion-week/users").to_return(:body => fixture("channel_contributors_response.json"))
    users = Trubl::Client.new.retrieve_channel_contributors("new-york-fashion-week")
    expect(users).to be_a Trubl::Users
    expect(users.pagination).to be_a Trubl::Pagination
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    some_request(:get, "/api/v1/channel/new-york-fashion-week/users").should have_been_made
  end

  it '.retrieve_channel_touts parses channel touts correctly' do
    stub_get("https://api.tout.com/api/v1/channel/new-york-fashion-week/touts").to_return(:body => fixture("channel_touts_response.json"))
    touts = Trubl::Client.new.retrieve_channel_touts("new-york-fashion-week")
    expect(touts).to be_a Trubl::Touts
    expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/channel/new-york-fashion-week/touts").should have_been_made
  end

end
