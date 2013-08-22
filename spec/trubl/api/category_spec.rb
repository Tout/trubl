require_relative '../../spec_helper'
require 'trubl/client'
require 'webmock'

describe Trubl::API::Category do

  let(:category_uid){"music"}

  it '.retrieve_categories parses a category list correctly' do
    stub_api_get("categories").to_return(:body => fixture("categories_response.json"))
    categories = Trubl::Client.new.retrieve_categories()
    expect(categories).to be_a Trubl::Categories
    categories.each do |c|
      expect(c).to be_a Trubl::Category
    end
    api_get_request("categories").should have_been_made
  end

  it '.retrieve_categories_popular_users parses category users correctly' do
    stub_api_get("categories/popular/users").to_return(:body => fixture("categories_popular_users_response.json"))
    users = Trubl::Client.new.retrieve_categories_popular_users()
    expect(users).to be_a Trubl::Users
    #expect(users.pagination).to be_a Trubl::Pagination
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    api_get_request("categories/popular/users").should have_been_made
  end

  it '.retrieve_categories_popular_channels parses category channels correctly' do
    stub_api_get("categories/popular/channels").to_return(:body => fixture("categories_popular_channels_response.json"))
    channels = Trubl::Client.new.retrieve_categories_popular_channels()
    expect(channels).to be_a Trubl::Channels
    #expect(users.pagination).to be_a Trubl::Pagination
    channels.each do |u|
      expect(u).to be_a Trubl::Channel
    end
    api_get_request("categories/popular/channels").should have_been_made
  end

  it '.retrieve_category parses a category response correctly' do
    stub_api_get("categories/#{category_uid}").to_return(:body => fixture("category_response.json"))
    category = Trubl::Client.new.retrieve_category(category_uid)
    expect(category).to be_a Trubl::Category
    expect(category.uid).to eq(category_uid)
    api_get_request("categories/#{category_uid}").should have_been_made
  end

  it '.retrieve_category_users parses category users correctly' do
    stub_api_get("categories/#{category_uid}/users").to_return(:body => fixture("category_users_response.json"))
    users = Trubl::Client.new.retrieve_category_users(category_uid)
    expect(users).to be_a Trubl::Users
    #expect(users.pagination).to be_a Trubl::Pagination
    users.each do |u|
      expect(u).to be_a Trubl::User
    end
    api_get_request("categories/#{category_uid}/users").should have_been_made
  end

  it '.retrieve_category_touts parses category touts correctly' do
    stub_api_get("categories/#{category_uid}/touts").to_return(:body => fixture("category_touts_response.json"))
    touts = Trubl::Client.new.retrieve_category_touts(category_uid)
    expect(touts).to be_a Trubl::Touts
    #expect(touts.pagination).to be_a Trubl::Pagination
    touts.each do |u|
      expect(u).to be_a Trubl::Tout
    end
    api_get_request("categories/#{category_uid}/touts").should have_been_made
  end

end
