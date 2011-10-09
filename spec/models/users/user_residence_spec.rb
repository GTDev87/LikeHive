require 'spec_helper'

describe UserResidence do  
  describe "User locations" do    
    it "should be valid with valid location added" do
      user_residence = Factory.build(:user_residence)
      user_residence.locations << Factory.build(:zipcode, :number => "11111")
      user_residence.should be_valid
    end
    
    it "should be invalid with invalid location added" do
      user_residence = Factory.build(:user_residence)
      user_residence.locations << Factory.build(:zipcode, :number => "1") 
      user_residence.should_not be_valid
    end
    
    it "should add location to user residence" do
      user_residence = Factory.build(:user_residence)
      user_residence.locations << Factory.build(:zipcode, :number => "11111")
      user_residence.locations.size.should == 1
    end
  end
end