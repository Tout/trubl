require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Streams do

  # todo: the fixture is not an authentic streams response, add one please
  it '.retrieve_stream_touts returns touts included in a stream' do
    stub_get("https://api.tout.com/api/v1/streams/s43x2f/touts").to_return(:body => fixture("streams_touts_response.json"))
    touts = Trubl::Client.new.retrieve_stream_touts('s43x2f')
    expect(touts).to be_a Trubl::Touts
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/streams/s43x2f/touts").should have_been_made
  end

  it '.retrieve_stream_touts_json returns touts included in a stream' do
    stub_get("https://api.tout.com/api/v1/streams/s43x2f/touts.json").to_return(:body => fixture("streams_touts_response.json"))
    touts = Trubl::Client.new.retrieve_stream_touts_json('s43x2f')
    expect(touts).to be_a Trubl::Touts
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/streams/s43x2f/touts.json").should have_been_made
  end
end
