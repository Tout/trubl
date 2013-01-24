require_relative "../spec_helper"
require "trapic/tout"

describe Trapic::Tout do
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  it "magically creates a Tout object from json" do
    tout = Trapic::Tout.new(json_fixture("tout.json")["tout"])
    expect(tout.uid).to eq("fhcl57")
  end

end