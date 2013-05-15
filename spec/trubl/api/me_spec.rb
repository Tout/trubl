require 'trubl/client'

describe Trubl::API::Me do

  it "retrieve_me returns my Trubl::User" do
    stub_get("https://api.tout.com/api/v1/me").to_return(:body => fixture("retrieve_me_response.json"))
    user = Trubl::Client.new.get_me()
    expect(user).to be_a Trubl::User
    some_request(:get, "/api/v1/me").should have_been_made
  end

  it ".get_my_authorizations returns my Trubl::Authorizations" do
    stub_get("https://api.tout.com/api/v1/me/authorizations").to_return(:body => fixture("me_authorizations_response.json"))
    authorizations = Trubl::Client.new.get_my_authorizations
    some_request(:get, "/api/v1/me/authorizations").should have_been_made
    expect(authorizations).to be_a Trubl::Authorizations
    expect(authorizations.size).to eq 1
    expect(authorizations.first.name).to eq 'Facebook'
  end

  it ".get_my_fb_sharing_settings returns json rep of fb settings" do
    stub_get("https://api.tout.com/api/v1/me/sharing/facebook").to_return(:body => fixture("me_fb_sharing_response.json"))
    json = Trubl::Client.new.get_my_fb_sharing_settings
    expect(json).to be_a Hash
    expect(json["via"]["name"]).to eq("Facebook")
  end

  it ".get_my_touts returns Touts instance" do
    stub_get("https://api.tout.com/api/v1/me/touts").to_return(:body => fixture("me_retrieve_user_touts_response.json"))
    touts = Trubl::Client.new.get_my_touts()
    expect(touts).to be_a Trubl::Touts
    some_request(:get, "/api/v1/me/touts").should have_been_made
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

end