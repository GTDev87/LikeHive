require 'spec_helper'

describe UserUsernameVisitor do  
  describe "To email parsing" do    
    it "should hold on to user emails" do
      @greg = Factory.build(:user, username: "GregT")
      @amol = Factory.build(:user, username: "AmolK")
      
      message_visitor = UserUsernameVisitor.new()
      message_visitor.visit_user(@greg)
      message_visitor.visit_user(@amol)
      
      message_visitor.user_list.should =~ [@greg.username, @amol.username]
    end
  end
end