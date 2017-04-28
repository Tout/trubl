require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Touts do

  let(:client) { Trubl::Client.new }

  it '.filtered_stream_membership_notify_create' do
    stub_post("https://api.tout.com/api/v1/filtered_stream_membership_notifications/create").to_return(:status => 202, :body => "true")
    result = client.filtered_stream_membership_notify_create([1,2,3,4])
    expect(result.body).to eq "true"
    some_request(:post, "/api/v1/filtered_stream_membership_notifications/create").should have_been_made
  end

  it '.filtered_stream_membership_notify_destroy' do
    stub_post("https://api.tout.com/api/v1/filtered_stream_membership_notifications/destroy").to_return(:status => 202, :body => "true")
    result = client.filtered_stream_membership_notify_destroy([1,2,3,4])
    expect(result.body).to eq "true"
    some_request(:post, "/api/v1/filtered_stream_membership_notifications/destroy").should have_been_made
  end
end
