require 'spec_helper'

describe UserEmailVisitor do  
  describe "To email parsing" do    
    it "should hold on to user emails" do
      @greg = Factory.build(:user, email: "greg@test.com")
      @amol = Factory.build(:user, email: "amol@test.com")
      
      message_visitor = UserEmailVisitor.new()
      message_visitor.visit_user(@greg)
      message_visitor.visit_user(@amol)
      
      message_visitor.user_list.should =~ [@greg.email, @amol.email]
    end
  end
end