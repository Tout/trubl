require 'spec_helper'
require 'trubl'

describe Trubl do
  describe ".client initialization" do

    it "returns a Trubl::Client" do
      expect(Trubl.client).to be_a Trubl::Client
    end

    it "Trubl::Client has nil credentials" do
      expect(Trubl.client.credentials).to eq({client_id:'', client_secret:'', access_token:nil})
    end

    it "is in fact a new client when instantiating a new instance" do
      client1 = Trubl.client("client1", "sekrit1")
      expect(client1.client_id).to eq("client1")
      client2 = Trubl.client("client2", "sekrit2")
      expect(client2.client_id).to eq("client2")
    end

  end
end