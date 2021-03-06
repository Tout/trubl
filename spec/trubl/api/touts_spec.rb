require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Touts do

  let(:client) { Trubl::Client.new }

  it '.retrieve_tout returns a Tout object' do
    stub_api_get("touts/fhcl57").to_return(:body => fixture("retrieve_tout.json"))
    tout = client.retrieve_tout("fhcl57")
    expect(tout).to be_a Trubl::Tout
    expect(tout.uid).to eq "fhcl57"
    some_request(:get, "/api/v1/touts/fhcl57").should have_been_made
  end

  describe '#retrieve_touts' do
    subject { client.retrieve_touts(uids) }

    context 'providing an array of users uids' do
      let(:sorted_uids) { 125.times.collect { |i| "test_tout_#{i}" }.sort }
      let(:uids)        { sorted_uids.shuffle }

      before do
        sorted_uids.in_groups_of(100, false) do |uid_group|
          fake_tout_response = {touts: uid_group.collect { |uid| {tout: {uid: uid} } } }

          stub_request(:get, "https://api.tout.com/api/v1/touts?uids=#{uid_group.join(',')}").
            to_return(
              status: 200,
              body: fake_tout_response.to_json,
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
      let(:uids) { 'random_tout' }
      before do
        stub_request(:get, "https://api.tout.com/api/v1/touts?uids=#{uids}").
          to_return(
            status: 200,
            body: {touts: [{tout: {uid: uids}}]}.to_json,
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

  it '.retrieve_thumbnails returns the Tout Thumbnails', focus:true do
    stub_api_get("touts/fhcl57/thumbnails").to_return(body: fixture("tout_thumbnails_response.json"))
    thumbnails = client.retrieve_thumbnails('fhcl57')
    expect(thumbnails).to be_a Trubl::Thumbnails
    expect(thumbnails.pagination).to be_a Trubl::Pagination
    thumbnails.each do |thumbnail|
      expect(thumbnail).to be_a Trubl::Thumbnail
    end
    some_request(:get, "/api/v1/touts/fhcl57/thumbnails").should have_been_made
  end

  it '.retrieve_latest returns the latest Touts' do
    stub_api_get("me/updates").to_return(:body => fixture("touts_me_updates_response.json"))
    touts = client.retrieve_updates()
    expect(touts).to be_a Trubl::Touts
    expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/me/updates").should have_been_made
  end

  it '.create_tout returns an object representing a newly created Tout' do
    stub_post("https://api.tout.com/api/v1/touts").to_return(:body => fixture('tout.json'))
    file = File.join(File.dirname(__FILE__), '../../fixtures/test.mp4')
    payload = {tout: { data: file, text: 'Some text here'}}
    tout = client.create_tout(payload)
    expect(tout).to be_a Trubl::Tout
    expect(tout.uid).to eq "fhcl57"
    some_request(:post, "/api/v1/touts").should have_been_made
  end

  it ".create_tout returns an object representing a newly created Tout from url" do
    stub_post("https://api.tout.com/api/v1/touts").to_return(:body => fixture('tout.json'))
    payload = {tout: { url: "http://test.com/filename", text: 'Some text here'}}
    tout = client.create_tout(payload)
    expect(tout).to be_a Trubl::Tout
    expect(tout.uid).to eq "fhcl57"
    some_request(:post, "/api/v1/touts").should have_been_made
  end

  describe '.update_tout' do
    let(:tout_uid) { 'some_random_tout_uid' }
    subject { client.update_tout(tout_uid, params) }

    context 'updating just the text' do
      let(:params) { {tout: {text: 'something new'} } }
      let(:url)    { "/api/v1/touts/#{tout_uid}" }
      before { stub_put("https://api.tout.com#{url}").to_return(result) }
      after  { some_request(:put, url).should have_been_made }

      context 'a success' do
        let(:result) { {status: 200, body: fixture('tout.json') }}
        it { should be_a Trubl::Tout }
      end
      context 'a failure' do
        let(:result) { {status: 500} }
        it { should be_nil }
      end
    end

    context 'not even hitting the api' do
      context 'blank payload' do
        let(:params) { {} }
        it { should be_nil }
      end
      context 'updating nothing' do
        let(:params) { {tout: nil} }
        it { should be_nil }
      end
      context 'updating more than the text' do
        let(:params) { {tout: {text: 'something new', privacy: 'public'}}}
        it 'should raise' do
          expect{subject}.to raise_exception
        end
      end
    end
  end

  it ".delete_tout returns true on 200 response" do
    stub_delete("https://api.tout.com/api/v1/touts/123456").to_return(:status => 200, :body => "true")
    result = client.delete_tout("123456")
    expect(result).to eq(true)
    some_request(:delete, "/api/v1/touts/123456").should have_been_made
  end

  it ".delete_tout returns false on non-200 response" do
    stub_delete("https://api.tout.com/api/v1/touts/234567").to_return(:status => 404, :body => "false")
    result = client.delete_tout("234567")
    expect(result).to eq(false)
    some_request(:delete, "/api/v1/touts/234567").should have_been_made
  end

  it '.filter_touts returns a collection of Touts' do
    stub_get("https://api.tout.com/api/v1/touts/filter").to_return(:body => fixture("latest_touts_response.json"))
    touts = client.filter_touts({tout_uids: ["fhcl57"]})
    expect(touts).to be_a Trubl::Touts
    expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:get, "/api/v1/touts/filter").should have_been_made
  end

  it '.filter_touts can be set to use post request' do
    stub_post("https://api.tout.com/api/v1/touts/filter").to_return(:body => fixture("latest_touts_response.json"))
    touts = client.filter_touts({tout_uids: ["fhcl57"]}, {method: :post})
    expect(touts).to be_a Trubl::Touts
    expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    some_request(:post, "/api/v1/touts/filter").should have_been_made
  end

  it '.publish_tout returns published Tout' do
    stub_put("https://api.tout.com/api/v1/touts/fhcl57/publish").to_return(:body => fixture('tout.json'))
    tout = client.publish_tout("fhcl57")
    expect(tout).to be_a Trubl::Tout
    some_request(:put, "/api/v1/touts/fhcl57/publish").should have_been_made
  end

  it '.publish_tout with user_uid option returns published Tout' do
    stub_put("https://api.tout.com/api/v1/touts/fhcl57/publish/by/aaron").to_return(:body => fixture('tout.json'))
    tout = client.publish_tout("fhcl57", by: 'aaron')
    expect(tout).to be_a Trubl::Tout
    some_request(:put, "/api/v1/touts/fhcl57/publish/by/aaron").should have_been_made
  end

  it '.schedule_tout with user_uid returns a scheduled_tout' do
    stub_post("https://api.tout.com/api/v1/touts/fhcl57/schedule/by/aaron").to_return(:body => fixture('tout.json'))
    result = client.schedule_tout("fhcl57", by: 'aaron', scheduled_at: Time.now, scheduled_date: Time.now + 5.days)
    expect(result).to be_a Trubl::Tout
    some_request(:post, "/api/v1/touts/fhcl57/schedule/by/aaron").should have_been_made
  end

  it '.reject_tout returns published Tout' do
    stub_put("https://api.tout.com/api/v1/touts/fhcl57/reject").to_return(:body => fixture('tout.json'))
    tout = client.reject_tout("fhcl57")
    expect(tout).to be_a Trubl::Tout
    some_request(:put, "/api/v1/touts/fhcl57/reject").should have_been_made
  end

  it '.reject_tout returns published Tout' do
    options = {by: 'aaron', rejection_reason: 'Violence'}
    stub_put("https://api.tout.com/api/v1/touts/fhcl57/reject/by/aaron").to_return(:body => fixture('tout.json'))
    tout = client.reject_tout("fhcl57", options)
    expect(tout).to be_a Trubl::Tout
    some_request(:put, "/api/v1/touts/fhcl57/reject/by/aaron").with(body: hash_including({rejection_reason: options[:rejection_reason]})).should have_been_made
  end

end
