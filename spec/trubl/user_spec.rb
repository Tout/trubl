# -*- encoding : utf-8 -*-

require_relative "../spec_helper"
require "trubl/user"

describe Trubl::User do
  include RSpecEncodingMatchers
  let(:user_uid) { 'karmin' }

  describe "update" do
    describe "with basic params" do
      let(:user_params) { {:email => 'new@test.com'} }

      it "sends a request to the update endpoint for the user" do
        stub_put("https://api.tout.com/api/v1/users/#{user_uid}").to_return(:body => fixture("user.json"))

        response = Trubl::User.update(user_uid, user_params)
        some_request(:put, "/api/v1/users/#{user_uid}").should have_been_made
        response.code.should eq(200)
      end
    end
  end

  it "magically creates a Tout object from json" do
    user = Trubl::User.new(json_fixture("user.json")["user"])
    expect(user.uid).to eq("karmin")
  end

  it "can handle utf-8 characters in a username" do
    user = Trubl::User.new(json_fixture("user_with_utf8.json")["user"])
    expect(user.uid).to eq("loðbrók")
    expect(user.uid).to be_encoded_as("UTF-8")
  end

  it "can handle utf-8 characters in a bio" do
    user = Trubl::User.new(json_fixture("user_with_utf8.json")["user"])
    expect(user.bio).to be_encoded_as("UTF-8")
  end
end
