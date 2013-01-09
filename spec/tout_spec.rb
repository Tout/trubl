require 'spec_helper'
require 'tout'

describe Tout do
  describe ".client initialization" do

    it "returns a Tout::Client" do
      expect(Tout.client).to be_a Tout::Client
    end

    it "Tout::Client has nil credentials" do
      expect(Tout.client.credentials).to eq({client_id:'', client_secret:'', access_token:nil})
    end

    it "is in fact a new client when instantiating a new instance" do
      stub_post("https://www.tout.com/oauth/token").with(:body => /.*/).to_return(body: fixture("client1_auth_resp.json"))
      client1 = Tout.client("client1", "sekrit1")
      client1.auth()
      expect(client1.client_id).to eq("client1")
      stub_post("https://www.tout.com/oauth/token").with(:body => /.*/).to_return(body: fixture("client2_auth_resp.json"))
      client2 = Tout.client("client2", "sekrit2")
      client2.auth()
      expect(client2.client_id).to eq("client2")
    end

  end
end