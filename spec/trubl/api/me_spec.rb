require 'spec_helper'
require 'trubl/client'

describe Trubl::API::Me do

  it "get_me returns my Trubl::User" do
    stub_get("https://api.tout.com/api/v1/me").to_return(:body => fixture("retrieve_me_response.json"))
    user = Trubl::Client.new.get_me()
    expect(user).to be_a Trubl::User
    some_request(:get, "/api/v1/me").should have_been_made
  end

  it "get_me_json returns my Trubl::User" do
    stub_get("https://api.tout.com/api/v1/me.json").to_return(:body => fixture("retrieve_me_response.json"))
    user = Trubl::Client.new.get_me_json()
    expect(user).to be_a Trubl::User
    some_request(:get, "/api/v1/me.json").should have_been_made
  end

  describe '.update_me' do
    subject { Trubl::Client.new.update_me(params) }

    context 'updating email and password' do
      let(:params) { {user: {email: 'user@example.com', password: '123456', password_confirmation: '123456'}} }
      let(:url) { "/api/v1/me" }
      before { stub_put("https://api.tout.com#{url}").to_return(result) }
      after { some_request(:put, url).should have_been_made }

      context 'a success' do
        let(:result) { {status: 200, body: fixture('update_me_response.json')} }
        it { should be_a Trubl::User }
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
        let(:params) { {user: nil} }
        it { should be_nil }
      end
      context 'updating unallowed property' do
        let(:params) { {user: {email: 'user@example.com', password: '123456', password_confirmation: '123456', friends_count: 1}} }
        it 'should raise' do
          expect { subject }.to raise_exception
        end
      end
    end
  end

  it ".get_my_authorizations returns my Trubl::Authorizations" do
    stub_get("https://api.tout.com/api/v1/me/authorizations").to_return(:body => fixture("me_authorizations_response.json"))
    authorizations = Trubl::Client.new.get_my_authorizations
    some_request(:get, "/api/v1/me/authorizations").should have_been_made
    expect(authorizations).to be_a Trubl::Authorizations
    expect(authorizations.size).to eq 1
    expect(authorizations.first.name).to eq 'Facebook'
  end

  it ".get_my_authorizations_json returns my Trubl::Authorizations" do
    stub_get("https://api.tout.com/api/v1/me/authorizations.json").to_return(:body => fixture("me_authorizations_response.json"))
    authorizations = Trubl::Client.new.get_my_authorizations_json
    some_request(:get, "/api/v1/me/authorizations.json").should have_been_made
    expect(authorizations).to be_a Trubl::Authorizations
    expect(authorizations.size).to eq 1
    expect(authorizations.first.name).to eq 'Facebook'
  end

  it ".get_my_settings returns my Trubl::Settings" do
    stub_get("https://api.tout.com/api/v1/me/settings").to_return(:body => fixture("me_settings_response.json"))
    settings = Trubl::Client.new.get_my_settings
    some_request(:get, "/api/v1/me/settings").should have_been_made
    expect(settings).to be_a Trubl::Settings
    expect(settings.size).to eq 3
    expect(settings.limits.tout_max_duration).to eq 15
  end

  it ".get_my_settings_json returns my Trubl::Settings" do
    stub_get("https://api.tout.com/api/v1/me/settings.json").to_return(:body => fixture("me_settings_response.json"))
    settings = Trubl::Client.new.get_my_settings_json
    some_request(:get, "/api/v1/me/settings.json").should have_been_made
    expect(settings).to be_a Trubl::Settings
    expect(settings.size).to eq 3
    expect(settings.limits.tout_max_duration).to eq 15
  end

  it ".get_my_fb_sharing_settings returns json rep of fb settings" do
    stub_get("https://api.tout.com/api/v1/me/sharing/facebook").to_return(:body => fixture("me_fb_sharing_response.json"))
    json = Trubl::Client.new.get_my_fb_sharing_settings
    expect(json).to be_a Hash
    expect(json["via"]["name"]).to eq("Facebook")
  end

  it ".get_my_fb_sharing_settings_json returns json rep of fb settings" do
    stub_get("https://api.tout.com/api/v1/me/sharing/facebook.json").to_return(:body => fixture("me_fb_sharing_response.json"))
    json = Trubl::Client.new.get_my_fb_sharing_settings_json
    expect(json).to be_a Hash
    expect(json["via"]["name"]).to eq("Facebook")
  end

  it ".get_my_touts returns Touts instance" do
    stub_get("https://api.tout.com/api/v1/me/touts").to_return(:body => fixture("me_retrieve_user_touts_response.json"))
    touts = Trubl::Client.new.get_my_touts()
    expect(touts).to be_a Trubl::Touts
    some_request(:get, "/api/v1/me/touts").should have_been_made
  end

  it ".get_my_scheduled_touts returns Touts instance" do
    stub_get("https://api.tout.com/api/v1/me/touts/scheduled").to_return(:body => fixture("me_retrieve_user_touts_response.json"))
    touts = Trubl::Client.new.get_my_scheduled_touts()
    expect(touts).to be_a Trubl::Touts
    some_request(:get, "/api/v1/me/touts/scheduled").should have_been_made
  end

  it ".get_my_rejected_touts returns Touts instance" do
    stub_get("https://api.tout.com/api/v1/me/touts/rejected").to_return(:body => fixture("me_retrieve_user_touts_response.json"))
    touts = Trubl::Client.new.get_my_rejected_touts()
    expect(touts).to be_a Trubl::Touts
    some_request(:get, "/api/v1/me/touts/rejected").should have_been_made
  end

  it ".get_my_pending_touts returns Touts instance" do
    stub_get("https://api.tout.com/api/v1/me/touts/pending").to_return(:body => fixture("me_retrieve_user_touts_response.json"))
    touts = Trubl::Client.new.get_my_pending_touts()
    expect(touts).to be_a Trubl::Touts
    some_request(:get, "/api/v1/me/touts/pending").should have_been_made
  end

  it ".get_updates returns Touts instance" do
    stub_get("https://api.tout.com/api/v1/me/updates").to_return(:body => fixture("me_retrieve_user_touts_response.json"))
    touts = Trubl::Client.new.get_updates()
    expect(touts).to be_a Trubl::Touts
    some_request(:get, "/api/v1/me/updates").should have_been_made
  end

  it ".get_my_liked_touts returns Touts instance" do
    stub_get("https://api.tout.com/api/v1/me/likes").to_return(:body => fixture("me_retrieve_user_liked_touts_response.json"))
    touts = Trubl::Client.new.get_my_liked_touts()
    expect(touts).to be_a Trubl::Touts
    some_request(:get, "/api/v1/me/likes").should have_been_made
  end

  it ".friends returns Users instance" do
    stub_get("https://api.tout.com/api/v1/me/friends").to_return(:body => fixture("me_friends_response.json"))
    users = Trubl::Client.new.friends()
    expect(users).to be_a Trubl::Users
    some_request(:get, "/api/v1/me/friends").should have_been_made
  end

  describe '.widgets' do
    before do
      stub_get("https://api.tout.com/api/v1/me/widgets").to_return(body: fixture("widgets.json"))
    end
    subject { Trubl::Client.new.widgets() }
    it { should be_kind_of Trubl::Widgets }
    it 'does the right api call' do
      subject
      some_request(:get, "https://api.tout.com/api/v1/me/widgets").should have_been_made
    end
  end

  it ".notifications returns Users instance" do
    stub_get("https://api.tout.com/api/v1/me/notifications").to_return(:body => fixture("me_notifications_response.json"))
    notifications = Trubl::Client.new.notifications()
    expect(notifications).to be_a Trubl::Notifications
    some_request(:get, "/api/v1/me/notifications").should have_been_made
  end

  it ".notification_inbox returns Users instance" do
    stub_get("https://api.tout.com/api/v1/me/notification_inbox").to_return(:body => fixture("me_notification_inbox_response.json"))
    notifications = Trubl::Client.new.notification_inbox()
    expect(notifications).to be_a Trubl::UserNotifications
    some_request(:get, "/api/v1/me/notification_inbox").should have_been_made
  end

  describe '.streams' do
    before do
      stub_get("https://api.tout.com/api/v1/me/streams").to_return(body: fixture("me_streams_response.json"))
    end
    subject { Trubl::Client.new.streams() }
    it { should be_kind_of Trubl::Streams }
    it 'does the right api call' do
      subject
      some_request(:get, "https://api.tout.com/api/v1/me/streams").should have_been_made
    end
  end

  describe '.devices' do
    before do
      stub_get("https://api.tout.com/api/v1/me/devices").to_return(body: fixture("me_devices_response.json"))
    end
    subject { Trubl::Client.new.devices() }
    it { should be_kind_of Trubl::Devices }
    it 'does the right api call' do
      subject
      some_request(:get, "https://api.tout.com/api/v1/me/devices").should have_been_made
    end
  end

  describe '.channels' do
    before do
      stub_get("https://api.tout.com/api/v1/me/channels").to_return(body: fixture("me_channels_response.json"))
    end
    subject { Trubl::Client.new.channels() }
    it { should be_kind_of Trubl::Channels }
    it 'does the right api call' do
      subject
      some_request(:get, "https://api.tout.com/api/v1/me/channels").should have_been_made
    end
  end

  describe '.suggested_hashtags' do
    before do
      stub_get("https://api.tout.com/api/v1/me/subscribed_hashtags").to_return(body: fixture("me_subscribed_hashtags_response.json"))
    end
    subject { Trubl::Client.new.subscribed_hashtags() }
    it { should be_kind_of Trubl::Hashtags }
    it 'does the right api call' do
      subject
      some_request(:get, "https://api.tout.com/api/v1/me/subscribed_hashtags").should have_been_made
    end
  end

  describe '.digestable_notifications' do
    before do
      stub_get("https://api.tout.com/api/v1/me/digestable_notifications").to_return(body: fixture("me_digestable_notifications_response.json"))
    end
    subject { Trubl::Client.new.digestable_notifications() }
    it { should be_kind_of Trubl::DigestableNotifications }
    it 'does the right api call' do
      subject
      some_request(:get, "https://api.tout.com/api/v1/me/digestable_notifications").should have_been_made
    end
  end

  describe '.blockees' do
    before do
      stub_get("https://api.tout.com/api/v1/me/blockees").to_return(body: fixture("me_blockees_response.json"))
    end
    subject { Trubl::Client.new.blockees() }
    it { should be_kind_of Trubl::Users }
    it 'does the right api call' do
      subject
      some_request(:get, "https://api.tout.com/api/v1/me/blockees").should have_been_made
    end
  end

end
