require_relative "../spec_helper"
require "tout/tout"

describe Tout::Touts::Tout do
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  it "magically creates a Tout object from json" do
    tout = Tout::Touts::Tout.new(json_fixture("tout.json")["tout"])
    expect(tout.uid).to eq("fhcl57")
  end

end