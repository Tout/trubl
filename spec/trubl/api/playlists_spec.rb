require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Playlists do

  it '.retrieve_playlist returns a playlist' do
    stub_get("https://api.tout.com/api/v1/playlists/s43x2f").to_return(:body => fixture("playlist_response.json"))
    playlist = Trubl::Client.new.retrieve_playlist('s43x2f')
    expect(playlist).to be_a Trubl::Playlist
    some_request(:get, "/playlists/s43x2f").should have_been_made
  end

  # todo: the fixture is not an authentic playlist response, add one please
  it '.retrieve_playlist_touts returns touts included in a playlist' do
    stub_get("https://api.tout.com/api/v1/playlists/s43x2f/touts").to_return(:body => fixture("playlist_touts_response.json"))
    touts = Trubl::Client.new.retrieve_playlist_touts('s43x2f')
    expect(touts).to be_a Trubl::Touts
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/playlists/s43x2f/touts").should have_been_made
  end

  it '.retrieve_playlist_touts_json returns touts included in a playlist' do
    stub_get("https://api.tout.com/api/v1/playlists/s43x2f/touts.json").to_return(:body => fixture("playlist_touts_response.json"))
    touts = Trubl::Client.new.retrieve_playlist_touts_json('s43x2f')
    expect(touts).to be_a Trubl::Touts
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/playlists/s43x2f/touts.json").should have_been_made
  end
end
