require 'spec_helper'

describe FacebookData do
  describe "validation" do
    it "should initialize with facebook data" do
      facebook_data = Factory.build(:facebook_data)
      
      facebook_data.should be_valid
    end
  end
end
