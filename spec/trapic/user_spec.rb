require_relative "../spec_helper"
require "trapic/user"

describe Trapic::User do
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  it "magically creates a Tout object from json" do
    user = Trapic::User.new(json_fixture("user.json")["user"])
    expect(user.uid).to eq("karmin")
  end

end