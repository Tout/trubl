require_relative '../../spec_helper'
require 'retout/client'
require 'webmock'

describe ReTout::API::Users do

  it '.retrieve_user returns a ReTout::User' do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = ReTout::Client.new.retrieve_user("karmin")
    expect(user).to be_a ReTout::User
    expect(user.uid).to eq("karmin")
    some_request(:get, "/api/v1/users/karmin").should have_been_made
  end

  it '.retrieve_user_likes returns a Collection of Touts liked by the specified user' do
    stub_get("https://api.tout.com/api/v1/users/karmin/likes").to_return(:body => fixture("touts_liked_by_user_response.json"))
    touts = ReTout::Client.new.retrieve_user_likes("karmin")
    expect(touts).to be_a ReTout::Touts
    expect(touts.pagination).to be_a ReTout::Pagination
    touts.each do |u|
      expect(u).to be_a ReTout::Tout
    end
    some_request(:get, "/api/v1/users/karmin/likes").should have_been_made
  end

  it '.retrieve_user_touts returns a Collection of Touts created by the specified user' do
    stub_get("https://api.tout.com/api/v1/users/teamtout/touts").to_return(:body => fixture("user_touts_response.json"))
    touts = ReTout::Client.new.retrieve_user_touts("teamtout")
    expect(touts).to be_a ReTout::Touts
    expect(touts.pagination).to be_a ReTout::Pagination
    touts.each do |u|
      expect(u).to be_a ReTout::Tout
    end
    some_request(:get, "/api/v1/users/teamtout/touts").should have_been_made
  end

  it '.retrieve_user_followers returns the Users following the specified user' do
    stub_get("https://api.tout.com/api/v1/users/teamtout/followers").to_return(:body => fixture("user_followers.json"))
    users = ReTout::Client.new.retrieve_user_followers("teamtout")
    expect(users).to be_a ReTout::Users
    expect(users.pagination).to be_a ReTout::Pagination
    users.each do |u|
      expect(u).to be_a ReTout::User
    end
    some_request(:get, "/api/v1/users/teamtout/followers").should have_been_made
  end

end
