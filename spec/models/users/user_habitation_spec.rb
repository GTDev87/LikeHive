require 'spec_helper'

describe UserHabitation do  
  describe "User locations" do    
    it "should be valid with valid location added" do
      user_habitation = Factory.build(:user_habitation)
      user_habitation.locations << Factory.build(:zipcode, :number => "11111")
      user_habitation.should be_valid
    end
    
    it "should be invalid with invalid location added" do
      user_habitation = Factory.build(:user_habitation)
      user_habitation.locations << Factory.build(:zipcode, :number => "1") 
      user_habitation.should_not be_valid
    end
    
    it "should add location to user habitation" do
      user_habitation = Factory.build(:user_habitation)
      user_habitation.locations << Factory.build(:zipcode, :number => "11111")
      user_habitation.locations.size.should == 1
    end
  end
end