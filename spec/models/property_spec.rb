require 'spec_helper'

describe Property do

  before(:each) do
    @property = FactoryGirl.build(:property)
  end

  it "should be valid" do
    @property.should be_valid
  end

end
