require 'spec_helper'

describe ContactMessageUsernameParser do  
  describe "To username parsing" do
    before(:each) do
      @greg = Factory(:user, username: "GregT")
      @reid = Factory(:user, username: "ReidH")
      @amol = Factory(:user, username: "AmolK")
      @zac = Factory(:user, username: "ZacC")
    end
    
    it "should add nothing if user list is empty" do
      message_array = []
      user_visitor = UserVisitor.new(message_array)
      email_parser = ContactMessageUsernameParser.new("")
      email_parser.return_user_list.accept_user_visitor(user_visitor)
      
      message_array.size.should == 0
    end
    
    it "should add nothing if user list is nil" do
      message_array = []
      user_visitor = UserVisitor.new(message_array)
      email_parser = ContactMessageUsernameParser.new(nil)
      email_parser.return_user_list.accept_user_visitor(user_visitor)
      
      message_array.size.should == 0
    end
    
    it "should add existing users to to list" do
      message_array = []
      user_visitor = UserVisitor.new(message_array)
      email_parser = ContactMessageUsernameParser.new("GregT, ReidH, AmolK, ZacC")
      email_parser.return_user_list.accept_user_visitor(user_visitor)
      
      message_array.size.should == 4
    end
    
    it "should not add users that do not exist to list" do
      message_array = []
      user_visitor = UserVisitor.new(message_array)
      email_parser = ContactMessageUsernameParser.new("GregT, ReidH, Foo, Bar")
      email_parser.return_user_list.accept_user_visitor(user_visitor)
      
      message_array.size.should == 2
    end    
    
    it "should not double count user" do
      message_array = []
      user_visitor = UserVisitor.new(message_array)
      email_parser = ContactMessageUsernameParser.new("GregT, GregT")
      email_parser.return_user_list.accept_user_visitor(user_visitor)
      
      message_array.size.should == 1
    end
  end
end