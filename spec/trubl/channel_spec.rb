
require 'spec_helper'
require 'trubl/channel'

describe Trubl::Channel do
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  it "magically creates a Tout object from json" do
    conversation = Trubl::Channel.new(json_fixture("channel_response.json")["channel"])
    expect(channel.uid).to eq("iummti53")
  end

end
