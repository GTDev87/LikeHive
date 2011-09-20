require 'spec_helper'

describe UserAge do  
  describe "Finding Age" do
    
    it "should return age when age is called" do
      user_age = UserAge.new(Factory(:user, :date_of_birth => "1987/06/27"))
      Timecop.freeze(2011, 9, 19)
      user_age.age.should == 24
      Timecop.return()
    end
    
    it "should return age from years ago" do
      user_age = UserAge.new(Factory(:user, :date_of_birth => "1987/06/27"))
      Timecop.freeze(2000, 9, 19)
      user_age.age.should == 13
      Timecop.return()
    end
  end
end