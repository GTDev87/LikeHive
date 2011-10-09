require 'spec_helper'

describe UserGender do  
  describe "Finding Gender" do
    it "should record gender" do    
      gender = Factory.build(:user_gender, :female => true)
      gender.female.should be_true
    end
    
    it "should record gender false" do    
      gender = Factory.build(:user_gender, :female => false)
      gender.female.should be_false
    end
  end
end