require 'spec_helper'

describe UserVisitor do  
  describe "To email parsing" do
    before(:each) do
      @greg = Factory(:user, email: "greg@test.com")
      @reid = Factory(:user, email: "reid@test.com")
      @amol = Factory(:user, email: "amol@test.com")
      @zac = Factory(:user, email: "zac@test.com")
    end
    
    it "should not add user to array if does not exist" do
      message_array = []
      message_visitor = UserVisitor.new(message_array)
      message_visitor.visit_user(nil)
      
      message_array.should == []
    end
    
    it "should not add users is user already exists" do
      message_array = [@greg]
      message_visitor = UserVisitor.new(message_array)
      message_visitor.visit_user(@greg)
      
      message_array.should == [@greg]
    end
    
    it "should add user if none in array" do
      message_array = []
      message_visitor = UserVisitor.new(message_array)
      message_visitor.visit_user(@greg)
      
      message_array.size.should == 1
      message_array[0].email == @greg.email
    end
    
    it "should add user if differnet user than in array" do
      message_array = [@amol]
      message_visitor = UserVisitor.new(message_array)
      message_visitor.visit_user(@greg)
      
      message_array.size.should == 2
    end
  end
end