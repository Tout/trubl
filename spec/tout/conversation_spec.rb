require_relative '../spec_helper'
require 'tout/conversation'
require 'tout/utils'

describe Tout::Conversation do
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  it "magically creates a Tout object from json" do
    conversation = Tout::Conversation.new(json_fixture("conversation_response.json")["conversation"])
    expect(conversation.uid).to eq("iummti53")
  end

end