require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Channel do

  let(:category_uid){"new-york-fashion-week"}

  it '.retrieve_channel parses a channel response correctly' do
    stub_api_get("channels/#{channel_uid}").to_return(:body => fixture("channel_response.json"))
    channel = Trubl::Client.new.retrieve_channel(channel_uid)
    expect(channel).to be_a Trubl::Channel
    expect(channel.uid).to eq(channel_uid)
    api_get_request("channels/#{channel_uid}").should have_been_made
  end

  it '.retrieve_channel_users parses channel users correctly' do
    stub_api_get("channels/#{channel_uid}/users").to_return(:body => fixture("channel_users_response.json"))
    users = Trubl::Client.new.retrieve_channel_users(channel_uid)
    expect(users).to be_a Trubl::Users
    #expect(users.pagination).to be_a Trubl::Pagination
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    api_get_request("channels/#{channel_uid}/users").should have_been_made
  end

  it '.retrieve_channel_touts parses channel touts correctly' do
    stub_api_get("channels/#{channel_uid}/touts").to_return(:body => fixture("channel_touts_response.json"))
    touts = Trubl::Client.new.retrieve_channel_touts(channel_uid)
    expect(touts).to be_a Trubl::Touts
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    api_get_request("channels/#{channel_uid}/touts").should have_been_made
  end

end
