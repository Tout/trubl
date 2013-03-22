require 'spec_helper'
require 'trubl/base'

describe Trubl::Base do

  subject{ Trubl::Base.new }

  let(:response){ 
    resp = double("Response")
    resp.stub(:body).and_return('{"base": {}}') 
    resp
  }

  let(:missing_response){ 
    resp = double("Response")
    resp.stub(:body).and_return('{"error": "resource not found"}') 
    resp.stub(:code).and_return(404) 
    resp
  }

  let(:error_response){ 
    resp = double("Response")
    resp.stub(:body).and_return('{"error": "kaboom"}') 
    resp.stub(:code).and_return(500) 
    resp
  }


  it "inherits from Hash" do
    subject.is_a? Hash
  end

  it "inherits from Hashie::Mash" do
    subject.is_a? Hashie::Mash
  end

  describe "#from_response" do

    it "returns nil if response code is 4xx" do
      missing_response.should_receive(:code)
      instance = subject.from_response(missing_response)
      instance.should be_nil
    end

    it "returns nil if response code is 5xx" do
      error_response.should_receive(:code)
      instance = subject.from_response(error_response)
      instance.should be_nil
    end

    it "parses the response body" do
      response.should_receive(:code)
      subject.should_receive(:parse).with(response)
      subject.from_response(response)
    end

    it "uses the inferred class name" do
      response.should_receive(:code)
      subject.should_receive(:klass_name)
      subject.from_response(response)
    end

    it "re-initializes the instance" do
      response.should_receive(:code)
      subject.should_receive :initialize
      subject.from_response(response)
    end

  end

  describe "#parse" do

    it "parses the response body into a json object" do
       JSON.should_receive(:parse).with(response.body).and_return({})
       subject.parse(response)
    end

  end

  describe "klass_name" do

    it "downcases the class name " do
      subject.klass_name.should == 'base'
    end

  end

end
