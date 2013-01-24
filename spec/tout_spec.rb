require 'spec_helper'
require 'retout'

describe ReTout do
  describe ".client initialization" do

    it "returns a ReTout::Client" do
      expect(ReTout.client).to be_a ReTout::Client
    end

    it "ReTout::Client has nil credentials" do
      expect(ReTout.client.credentials).to eq({client_id:nil, client_secret:nil, access_token:nil})
    end

    it "is in fact a new client when instantiating a new instance" do
      client1 = ReTout.client("client1", "sekrit1", access_token: "client1")
      expect(client1.client_id).to eq("client1")
      client2 = ReTout.client("client2", "sekrit2", access_token: "client2")
      expect(client2.client_id).to eq("client2")
    end

  end
end