require 'spec_helper'

  describe Collection do
    before(:each) do
    @collection = FactoryGirl.build(:collection_with_properties)
  end

  it "should be valid" do
    @collection.should be_valid
  end
end
