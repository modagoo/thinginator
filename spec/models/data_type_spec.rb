require 'spec_helper'

describe DataType do

  before(:each) do
    @data_type = FactoryGirl.build(:data_type)
  end

  it "should be valid" do
    @data_type.should be_valid
  end

end
