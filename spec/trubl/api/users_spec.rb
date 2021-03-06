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

  describe "#create_user" do
    context "with valid params" do
      let(:user_params) { { email: 'new@test.com', password: 'user123!' } }

      it "sends a request to the create endpoint for the user" do
        stub_post("https://api.tout.com/api/v1/users").to_return(body: fixture("user.json"))

        response = Trubl::Client.new.create_user(user_params)
        some_request(:post, "/api/v1/users").should have_been_made
        response.code.should eq(200)
      end
    end

    context "with invalid params" do
      let(:user_params) { { email: '', password: '' } }
      let(:error_response) { { error: ["Email is invalid", "Password can't be blank"] } }

      it "sends a request to the create endpoint for the user and returns response" do
        stub_post("https://api.tout.com/api/v1/users").to_return(status: 422, body: error_response.to_json)

        response = Trubl::Client.new.create_user(user_params)
        some_request(:post, "/api/v1/users").should have_been_made
        response.code.should eq(422)
        response.body.should eq(error_response.to_json)
      end
    end
  end

  describe '#update_watermark_from_url' do
    let(:user_uid) { 'some_user'}
    let(:watermark_url) { 'http://s3.com/watermark.png'}
    let(:request_path) {"https://api.tout.com/api/v1/users/#{user_uid}/watermark"}

    it 'executes a watermark update via url for a user' do
      stub_put(request_path).to_return(:body => "{}")
      client.update_watermark_from_url(user_uid, watermark_url)
      a_request(:put, request_path).
               with(:body => 'watermark[image_url]=http%3A%2F%2Fs3.com%2Fwatermark.png').
               should have_been_made
    end
  end



end
