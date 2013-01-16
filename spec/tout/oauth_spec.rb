require 'spec_helper'
require 'tout/oauth'

describe Tout::OAuth do

  before do
    @client = Tout.client()
  end

  describe ".auth" do

    it "parses json and stores attributes properly" do
      stub_post("https://www.tout.com/oauth/token").with(:body => /.*/).to_return(body: fixture("client1_auth_resp.json"))
      @client.auth()
      expect(@client.access_token).to eq("6bffd46fca32a9dc640a7f2284edd55b5175d59323923f984b92ee5ec6a0a9e4")
    end

    it "raises Exception when cannot retrieve access_token" do
      stub_post("https://www.tout.com/oauth/token").with(:body => /.*/).to_return(body: "{}")
      expect(lambda {@client.auth()}).to raise_error(RuntimeError)

    end

  end
end