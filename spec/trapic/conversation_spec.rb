require 'spec_helper'
require 'trapic/conversation'

describe Trapic::Conversation do
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  it "magically creates a Tout object from json" do
    conversation = Trapic::Conversation.new(json_fixture("conversation_response.json")["conversation"])
    expect(conversation.uid).to eq("iummti53")
  end

end
