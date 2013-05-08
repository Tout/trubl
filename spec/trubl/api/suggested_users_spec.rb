require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Suggested_Users do

  # todo: the fixture is not an authentic streams response, add one please
  it '.retrieve_stream_touts returns touts included in a stream' do
    stub_get("https://api.tout.com/api/v1/suggested_users.json").to_return(:body => fixture("suggested_users_response.json"))
    touts = Trubl::Client.new.suggested_users('wwe')
    expect(touts).to be_a Trubl::Users
    touts.each do |u|
      expect(u).to be_a Trubl::User
    end
    some_request(:get, "/suggested_users.json").should have_been_made
  end
end
