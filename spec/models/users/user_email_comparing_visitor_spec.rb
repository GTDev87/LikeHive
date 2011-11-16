require 'spec_helper'

describe UserEmailComparingVisitor do  
  describe "To email parsing" do    
    
    it "should not find user if user is nil" do
      @user = Factory.build(:user, email: "greg@test.com")
      message_visitor = UserEmailComparingVisitor.new(@user)
      message_visitor.visit_user(nil)
      
      message_visitor.found_user.should == false
    end
    
    it "should not find user if user is incorrect" do
      @user = Factory.build(:user, email: "greg@test.com")
      message_visitor = UserEmailComparingVisitor.new(@user)
      message_visitor.visit_user(Factory.build(:user))
      
      message_visitor.found_user.should == false
    end
    
    it "should find user if user is correct" do
      @user = Factory.build(:user, email: "greg@test.com")
      message_visitor = UserEmailComparingVisitor.new(@user)
      message_visitor.visit_user(@user)
      
      message_visitor.found_user.should == true
    end
  end
end