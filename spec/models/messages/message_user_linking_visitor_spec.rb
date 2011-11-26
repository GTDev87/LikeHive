require 'spec_helper'

describe MessageUserLinkingVisitor do  
  describe "assigning messages to users" do
    before(:each) do
      @greg = Factory.build(:user, email: "greg@test.com")
      @amol = Factory.build(:user, email: "amol@test.com")
      @zac = Factory.build(:user, email: "zac@test.com")
      @reid = Factory.build(:user, email: "reid@test.com")
    end
    
    it "should assign message to user" do
      message = Factory.build(:contact_message, message_data: Factory.build(:message_data, from: @greg, to: [@amol], body: "Sent Message"))
      
      message_user_visitor = MessageUserLinkingVisitor.new(message)
      message_user_visitor.visit_user(@greg)
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.message_data.body.should == "Sent Message"
    end
  end
end