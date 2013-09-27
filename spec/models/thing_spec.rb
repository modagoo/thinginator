require 'spec_helper'

describe Thing do

  before(:each) do
    @thing = FactoryGirl.build(:thing_with_property)
  end

  # it "should be valid" do
  #   @thing.should be_valid
  # end

end
