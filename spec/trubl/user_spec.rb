# -*- encoding : utf-8 -*-

require_relative "../spec_helper"
require "trubl/user"

describe Trubl::User do
  include RSpecEncodingMatchers
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

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

  it ".like is a usable verb when created via a client" do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = Trubl::Client.new.retrieve_user("karmin")
    stub_get("https://api.tout.com/api/v1/users/karmin/likes").to_return(:body => fixture("touts_liked_by_user_response.json"))
    touts = user.likes
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/users/karmin/likes").should have_been_made
  end

  it ".likes is a usable verb when created via a client" do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = Trubl::Client.new.retrieve_user("karmin")
    stub_get("https://api.tout.com/api/v1/users/karmin/touts").to_return(:body => fixture("user_touts_response.json"))
    touts = user.touts
    expect(touts).to be_a Trubl::Touts
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/users/karmin/touts").should have_been_made
  end

  it ".followers is a usable verb when created via a client" do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = Trubl::Client.new.retrieve_user("karmin")
    stub_get("https://api.tout.com/api/v1/users/karmin/followers").to_return(:body => fixture("user_followers.json"))
    users = user                                  .followers
    expect(users).to be_a Trubl::Users
    #expect(users.pagination).to be_a Trubl::Pagination
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    some_request(:get, "/api/v1/users/karmin/followers").should have_been_made
  end

end
