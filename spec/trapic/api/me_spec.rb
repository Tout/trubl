require 'trapic/client'

describe Trapic::API::Me do

  it "retrieve_me returns my Trapic::User" do
    stub_get("https://api.tout.com/api/v1/me").to_return(:body => fixture("retrieve_me_response.json"))
    user = Trapic::Client.new.get_me()
    expect(user).to be_a Trapic::User
    some_request(:get, "/api/v1/me").should have_been_made

  end
end