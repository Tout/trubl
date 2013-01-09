require "spec_helper"
require "tout/client"

describe Tout::Client do

  it "instantiates a new Tout::Client instance" do
    expect(Tout::Client.new()).to be_a Tout::Client
  end

  describe ".auth" do
    it "stores access_token" do
      body = "client_id=&client_secret=&grant_type=client_credentials"
      stub_post("https://www.tout.com/oauth/token").with(body: body).to_return(body: fixture("client1_auth_resp.json"))
      client = Tout::Client.new()
      client.auth()
      expect(client.access_token).to eq "6bffd46fca32a9dc640a7f2284edd55b5175d59323923f984b92ee5ec6a0a9e4"
    end
  end

  describe ".credentials" do
    it "returns a hash of creds" do
      body = "client_id=client_id&client_secret=client_sekrit&grant_type=client_credentials"
      stub_post("https://www.tout.com/oauth/token").with(body: body).to_return(body: fixture("client1_auth_resp.json"))
      client = Tout::Client.new("client_id", "client_sekrit")
      client.auth()
      expect(client.credentials).to eq({client_id:"client_id", client_secret:"client_sekrit", access_token:"6bffd46fca32a9dc640a7f2284edd55b5175d59323923f984b92ee5ec6a0a9e4"})

    end
  end

end
