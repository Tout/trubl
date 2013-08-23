require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Users do

  let(:client) { Trubl::Client.new }

  it '.featured_users returns a Trubl::Users' do
    stub_get("https://api.tout.com/api/v1/featured_users").to_return(:body => fixture("featured_users_response.json"))
    users = client.featured_users
    expect(users).to be_a Trubl::Users
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    some_request(:get, "/api/v1/featured_users").should have_been_made
  end

  it '.retrieve_user returns a Trubl::User' do
    stub_get("https://api.tout.com/api/v1/users/karmin").to_return(:body => fixture("user.json"))
    user = client.retrieve_user("karmin")
    expect(user).to be_a Trubl::User
    expect(user.uid).to eq("karmin")
    some_request(:get, "/api/v1/users/karmin").should have_been_made
  end

  describe '#retrieve_users' do
    subject { client.retrieve_users(uids) }

    context 'providing an array of users uids' do
      let(:sorted_uids) { 125.times.collect { |i| "test_user_#{i}" }.sort }
      let(:uids)        { sorted_uids.shuffle } 

      before do
        sorted_uids.in_groups_of(100, false) do |uid_group|
          fake_user_response = {users: uid_group.collect { |uid| {user: {uid: uid} } } }

          stub_request(:get, "https://api.tout.com/api/v1/users?uids=#{uid_group.join(',')}").
            to_return(
              status: 200, 
              body: fake_user_response.to_json,
              headers: {}
            )
        end
      end

      its(:size) { should == uids.size }
      it 'should contain the users' do
        expect(subject.map(&:uid).sort).to eq sorted_uids
      end
    end

    context 'providing a single uid as string' do
      let(:uids) { 'zackryder' }
      before do
        stub_request(:get, "https://api.tout.com/api/v1/users?uids=#{uids}").
          to_return(
            status: 200, 
            body: {users: [{user: {uid: uids}}]}.to_json,
            headers: {}
          )
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

  it '.retrieve_user_following returns the Users the specified user follows' do
    stub_get("https://api.tout.com/api/v1/users/teamtout/following").to_return(:body => fixture("user_following.json"))
    users = client.retrieve_user_following("teamtout")
    expect(users).to be_a Trubl::Users
    #expect(users.pagination).to be_a Trubl::Pagination
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    some_request(:get, "/api/v1/users/teamtout/following").should have_been_made
  end


  it '.follow_user executes a follow for the specified user with a user authed token' do
    stub_post("https://api.tout.com/api/v1/users/teamtout/follow").to_return(:body => "")
    client.follow_user('teamtout')
    some_request(:post, "/api/v1/users/teamtout/follow").should have_been_made
  end

   describe '.retrieve_user_widgets' do
    let(:user_uid) { 'teamtout'}
    let(:path)     { "https://api.tout.com/api/v1/users/#{user_uid}/widgets" }
    before do
      stub_get(path).to_return(body: fixture("widgets.json"))
    end
    subject { Trubl::Client.new.retrieve_user_widgets(user_uid) }
    it { should be_kind_of Trubl::Widgets }
    it 'does the right api call' do
      subject
      some_request(:get,path).should have_been_made
    end
  end 
  
  describe '#block_user_by' do
    let(:user_uid) { 'some_user'}
    let(:blocker_uid) { 'some_blocker'}
    let(:request_path) {"https://api.tout.com/api/v1/users/#{user_uid}/blocks/by/#{blocker_uid}"}
    
    it 'executes a blocking of a user by another (blocker) user' do
      stub_post(request_path).to_return(:body => "")
      client.block_user_by(user_uid, blocker_uid)
      some_request(:post, request_path).should have_been_made
    end
  end
  
  describe '#unblock_user_by' do
    let(:user_uid) { 'some_user'}
    let(:blocker_uid) { 'some_blocker'}
    let(:request_path) {"https://api.tout.com/api/v1/users/#{user_uid}/blocks/by/#{blocker_uid}"}
    
    it 'executes an unblocking of a user by another (blocker) user' do
      stub_delete(request_path).to_return(:body => "")
      client.unblock_user_by(user_uid, blocker_uid)
      some_request(:delete, request_path).should have_been_made
    end
  end

  describe '#update_watermark_from_url' do
    let(:user_uid) { 'some_user'}
    let(:watermark_url) { 'http://s3.com/watermark.png'}
    let(:request_path) {"https://api.tout.com/api/v1/users/#{user_uid}/watermark"}
    
    it 'executes a watermark update via url for a user' do
      stub_put(request_path).to_return(:body => "{}")
      client.update_watermark_from_url(user_uid, watermark_url)
      some_request(:put, request_path).should have_been_made
    end
  end



end
