require 'spec_helper'
require 'trubl/client'

describe Trubl::API::Metrics do

  it "user_metrics returns a Trubl::User" do
    stub_get("https://api.tout.com/api/v1/metrics/me").to_return(:body => fixture("metrics_me_response.json"))
    user = Trubl::Client.new.user_metrics()
    expect(user).to be_a Trubl::Metrics
    some_request(:get, "/api/v1/metrics/me").should have_been_made
  end

  it "user_metrics_audience returns a Trubl::User" do
    stub_get("https://api.tout.com/api/v1/metrics/me/audience/inception").to_return(:body => fixture("metrics_audience_response.json"))
    user = Trubl::Client.new.user_metrics_audience()
    expect(user).to be_a Trubl::Metrics
    some_request(:get, "/api/v1/metrics/me/audience/inception").should have_been_made
  end

  it "user_metrics_views returns a Trubl::User" do
    stub_get("https://api.tout.com/api/v1/metrics/me/views/inception").to_return(:body => fixture("metrics_views_response.json"))
    user = Trubl::Client.new.user_metrics_views()
    expect(user).to be_a Trubl::Metrics
    some_request(:get, "/api/v1/metrics/me/views/inception").should have_been_made
  end

end
