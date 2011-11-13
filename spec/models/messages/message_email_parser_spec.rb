require 'spec_helper'

describe MessageEmailParser do  
  describe "To email parsing" do
    before(:each) do
      @greg = Factory(:user, email: "greg@test.com")
      @reid = Factory(:user, email: "reid@test.com")
      @amol = Factory(:user, email: "amol@test.com")
      @zac = Factory(:user, email: "zac@test.com")
    end
    
    it "should add existing users to to lsit" do
      message_array = []
      message_visitor = MessageToEmailVisitor.new(message_array)
      email_parser = MessageEmailParser.new("greg@test.com, reid@test.com, amol@test.com, zac@test.com")
      email_parser.accept_email_string(message_visitor)
      
      message_array.size.should == 4
    end
    
    it "should not add users that do not exist to list" do
      message_array = []
      message_visitor = MessageToEmailVisitor.new(message_array)
      email_parser = MessageEmailParser.new("greg@test.com, reid@test.com, foo@test.com, bar@test.com")
      email_parser.accept_email_string(message_visitor)
      
      message_array.size.should == 2
    end
    
    it "should find users reguardless of casing" do
      message_array = []
      message_visitor = MessageToEmailVisitor.new(message_array)
      email_parser = MessageEmailParser.new("Greg@Test.com, rEiD@tEsT.com, amoL@test.com, ZAC@test.com")
      email_parser.accept_email_string(message_visitor)
      
      message_array.size.should == 4
    end
    
    it "should not double count user" do
      message_array = []
      message_visitor = MessageToEmailVisitor.new(message_array)
      email_parser = MessageEmailParser.new("greg@test.com, greg@test.com")
      email_parser.accept_email_string(message_visitor)
      
      message_array.size.should == 1
    end
  end
end