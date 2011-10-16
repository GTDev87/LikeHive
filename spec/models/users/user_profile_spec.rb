require 'spec_helper'

describe UserProfile do  
  describe "Validates profile" do
    it "should validate valid profile" do
      profile = Factory.build(:user_profile)
      
      profile.should be_valid
    end
    
    it "should require valid birthday" do    
      profile_invalid_age = Factory.build(:user_profile, :age => Factory.build(:user_age, :date_of_birth => ""))
    
      profile_invalid_age.should_not be_valid
    end
  
    it "should require non nil birthday" do    
      profile_invalid_age = Factory.build(:user_profile, :age => nil)
    
      profile_invalid_age.should_not be_valid
    end
  
    it "should require valid name" do
      profile_invalid_name = Factory.build(:user_profile, :name => Factory.build(:user_name, :first => ""))
    
      profile_invalid_name.should_not be_valid
    end
  
    it "should require non nil name" do
      profile_invalid_name = Factory.build(:user_profile, :name => nil)
    
      profile_invalid_name.should_not be_valid
    end
  
    it "should require valid gender" do
      profile_invalid_gender = Factory.build(:user_profile, :gender => Factory.build(:user_gender, :female => nil))
    
      profile_invalid_gender.should_not be_valid
    end
  
    it "should require non nil gender" do
      profile_invalid_gender = Factory.build(:user_profile, :gender => nil)
    
      profile_invalid_gender.should_not be_valid
    end
  end
end