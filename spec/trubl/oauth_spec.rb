require 'spec_helper'
require 'trubl/oauth'

describe Trubl::OAuth do

  describe ".auth" do

    it "parses json and stores attributes properly" do
      stub_post("https://www.tout.com/oauth/token").with(:body => /.*/).to_return(body: fixture("client1_auth_resp.json"))
      @client = Trubl.client()
      @client.client_auth()
      expect(@client.access_token).to eq("6bffd46fca32a9dc640a7f2284edd55b5175d59323923f984b92ee5ec6a0a9e4")
    end

  end

  describe ".user_auth" do

    it "handles the password auth scheme properly" do
      stub_post("https://www.tout.com/oauth/token").with(:body => /.*/).to_return(body: fixture("client1_auth_resp.json"))
      @client = Trubl.client('client_id', 'client_secret', 'callback_url', email: 'fake@tout.com', password: 'password')
      @client.user_auth()
      expect(@client.access_token).to eq("6bffd46fca32a9dc640a7f2284edd55b5175d59323923f984b92ee5ec6a0a9e4")
    end
  end

end