require_relative '../spec_helper'

describe ReTout::Utils do

  it "builds a handy uri" do
    uri = ReTout::Utils.uri_builder("https://api.tout.com/", "api/", "v1/", "users")
    expect(uri).to eq("https://api.tout.com/api/v1/users")
  end

end