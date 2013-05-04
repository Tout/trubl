require 'spec_helper'
require 'trubl/category'

describe Trubl::Category do
  # this is the silly namespace one
  # this is also an example of the simple OpenStruct usage, to be replaced eventually

  let(:category_uid){"music"}

  it "magically creates a Tout object from json" do
    category = Trubl::Category.new(json_fixture("category_response.json")["category"])
    expect(category.uid).to eq(category_uid)
  end

end
