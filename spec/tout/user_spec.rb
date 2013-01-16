require_relative "../spec_helper"
require "tout/user"

describe Tout::User do
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  it "magically creates a Tout object from json" do
    user = Tout::User.new(json_fixture("user.json")["user"])
    expect(user.uid).to eq("karmin")
  end

end