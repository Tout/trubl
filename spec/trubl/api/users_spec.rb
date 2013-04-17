require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Users do

  let(:client) { Trubl::Client.new }

  it '.retrieve_user returns a Trubl::User' do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = client.retrieve_user("karmin")
    expect(user).to be_a Trubl::User
    expect(user.uid).to eq("karmin")
    some_request(:get, "/api/v1/users/karmin").should have_been_made
  end

  describe '#retrieve_users' do
    subject(:users) { client.retrieve_users(uids) }

    let(:requests) { (uids.is_a?(Array) ? uids : [uids]).collect { |uid| {path: "users/#{uid}"} } }

    context 'providing an array of users uids' do
      let(:uids) { %w(wwe zackryder) }

      before do
        responses = json_fixture("users.json").collect { |u| double :user, status: 200, body: u.to_json }

        client.should_receive(:multi_request).with(:get, requests).and_return(responses)
      end

      its(:size) { should == uids.size }
      it 'should contain the users' do
        expect(users.map(&:uid)).to eq uids
      end
    end

    context 'providing a single uid as string' do
      let(:uids) { 'zackryder' }
      before do
        responses = [double(:user, body: json_fixture("users.json").find{ |u| u['user']['uid'] == uids}.to_json)]

        client.
          should_receive(:multi_request).
          with(:get, requests).
          and_return responses
      end
      its(:size)       { should == 1 }
      its('first.uid') { should == uids }
    end

    context 'providing a blank list' do
      let(:uids) { nil }
      before do
        client.should_not_receive(:multi_request)
      end
      it { should == [] }
    end
    
  end


  it '.retrieve_user_likes returns a Collection of Touts liked by the specified user' do
    stub_get("https://api.tout.com/api/v1/users/karmin/likes").to_return(:body => fixture("touts_liked_by_user_response.json"))
    touts = client.retrieve_user_likes("karmin")
    expect(touts).to be_a Trubl::Touts
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/users/karmin/likes").should have_been_made
  end

  it '.retrieve_user_touts returns a Collection of Touts created by the specified user' do
    stub_get("https://api.tout.com/api/v1/users/teamtout/touts").to_return(:body => fixture("user_touts_response.json"))
    touts = client.retrieve_user_touts("teamtout")
    expect(touts).to be_a Trubl::Touts
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/users/teamtout/touts").should have_been_made
  end

  it '.retrieve_user_followers returns the Users following the specified user' do
    stub_get("https://api.tout.com/api/v1/users/teamtout/followers").to_return(:body => fixture("user_followers.json"))
    users = client.retrieve_user_followers("teamtout")
    expect(users).to be_a Trubl::Users
    #expect(users.pagination).to be_a Trubl::Pagination
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    some_request(:get, "/api/v1/users/teamtout/followers").should have_been_made
  end

  it '.follow_user executes a follow for the specified user with a user authed token' do
    stub_post("https://api.tout.com/api/v1/users/teamtout/follow").to_return(:body => "")
    client.follow_user('teamtout')
    some_request(:post, "/api/v1/users/teamtout/follow").should have_been_made
  end

end
