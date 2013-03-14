require_relative "../spec_helper"
require "trubl/hashtag"

describe Trubl::Hashtag do

  it "magically creates a Hashtag object from json" do
    hashtag = Trubl::Hashtag.new(json_fixture("hashtag_response.json")["hashtag"])
    expect(hashtag.uid).to eq("pets")
  end

end
