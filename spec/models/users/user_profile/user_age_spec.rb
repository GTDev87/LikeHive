require 'spec_helper'

describe UserAge do  
  describe "Finding Age" do
    it "should require date of birth" do
      invalid_user_age = Factory.build(:user_age, :date_of_birth => "")
      invalid_user_age.should_not be_valid
    end
    
    it "should have properly formatted date of birth" do
      user_age = Factory.build(:user_age, :date_of_birth => "1987/06/27")
      user_age.should be_valid
    end
    
    it "should record date of birth" do
      user_age = Factory.build(:user_age, :date_of_birth => "1987/06/27")
      user_age.date_of_birth == "1987/06/27"
    end
    
    it "should return age when age is called" do
      user_age = Factory.build(:user_age, :date_of_birth => "1987/06/27")
      Timecop.freeze(2011, 9, 19)
      user_age.age_in_years.should == 24
      Timecop.return()
    end
    
    it "should return age from years ago" do
      user_age = Factory.build(:user_age, :date_of_birth => "1987/06/27")
      Timecop.freeze(2000, 9, 19)
      user_age.age_in_years.should == 13
      Timecop.return()
    end
  end
end