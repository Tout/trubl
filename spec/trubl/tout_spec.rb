require_relative "../spec_helper"
require "trubl/tout"

describe Trubl::Tout do
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  it "magically creates a Tout object from json" do
    tout = Trubl::Tout.new(json_fixture("tout.json")["tout"])
    expect(tout.uid).to eq("fhcl57")
  end

  it ".delete is a usable verb when created via a client" do
    stub_post("https://api.tout.com/api/v1/touts").to_return(:body => fixture('tout.json'))
    file = File.join(File.dirname(__FILE__), '../fixtures/test.mp4')
    payload = {tout: { data: file, text: 'Some text here'}}
    tout = Trubl::Client.new.create_tout(payload)
    stub_delete("https://api.tout.com/api/v1/touts")
    result = tout.delete
    expect(result). to eq(true)
    some_request(:delete, "/api/v1/touts/fhcl57").should have_been_made
  end

  it ".like is a usable verb when created via a client" do
    stub_get("https://api.tout.com/api/v1/touts/fhcl57").to_return(:body => fixture("retrieve_tout.json"))
    tout = Trubl::Client.new.retrieve_tout("fhcl57")
    stub_post("https://api.tout.com/api/v1/touts/fhcl57/likes").to_return(:body => fixture("like_tout_response.json"))
    result = tout.like
    expect(result). to eq(true)
    some_request(:post, "/api/v1/touts/fhcl57/likes").should have_been_made
  end

  it ".unlike is a usable verb when created via a client" do
    stub_get("https://api.tout.com/api/v1/touts/fhcl57").to_return(:body => fixture("retrieve_tout.json"))
    tout = Trubl::Client.new.retrieve_tout("fhcl57")
    stub_delete("https://api.tout.com/api/v1/touts/fhcl57/likes").to_return(:body => fixture("unlike_tout_response.json"))
    result = tout.unlike
    expect(result). to eq(true)
    some_request(:delete, "/api/v1/touts/fhcl57/likes").should have_been_made
  end

end