require 'spec_helper'
require 'trapic'

describe Trapic do
  describe ".client initialization" do

    it "returns a Trapic::Client" do
      expect(trapic.client).to be_a trapic::Client
    end

    it "Trapic::Client has nil credentials" do
      expect(trapic.client.credentials).to eq({client_id:'', client_secret:'', access_token:nil})
    end

    it "is in fact a new client when instantiating a new instance" do
      client1 = trapic.client("client1", "sekrit1")
      expect(client1.client_id).to eq("client1")
      client2 = trapic.client("client2", "sekrit2")
      expect(client2.client_id).to eq("client2")
    end

  end
end