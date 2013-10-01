require 'spec_helper'

  describe Collection do
    before(:each) do
    @collection = FactoryGirl.build(:collection)
  end

  it "should be valid" do
    @collection.should be_valid
  end
end
