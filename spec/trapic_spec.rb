require 'spec_helper'
require 'trapic'

describe Trapic do
  describe ".client initialization" do

    it "returns a Trapic::Client" do
      expect(Trapic.client).to be_a Trapic::Client
    end

    it "Trapic::Client has nil credentials" do
      expect(Trapic.client.credentials).to eq({client_id:'', client_secret:'', access_token:nil})
    end

    it "is in fact a new client when instantiating a new instance" do
      client1 = Trapic.client("client1", "sekrit1")
      expect(client1.client_id).to eq("client1")
      client2 = Trapic.client("client2", "sekrit2")
      expect(client2.client_id).to eq("client2")
    end

  end
end