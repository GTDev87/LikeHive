require 'spec_helper'

describe MessageUserAssigner do  
  describe "assigning messages to users" do
    before(:each) do
      @greg = Factory.build(:user, email: "greg@test.com")
      @amol = Factory.build(:user, email: "amol@test.com")
      @zac = Factory.build(:user, email: "zac@test.com")
      @reid = Factory.build(:user, email: "reid@test.com")
    end
    
    it "should assign message to_list and from_list to users" do
      message = Factory.build(:message, from: @greg, to: [@amol], body: "Sent Message")
      
      message_assigner = MessageUserAssigner.new(message)
      message_assigner.assign_message_to_users()
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.body.should == "Sent Message"
      
      @amol.mailbox.messages.size.should == 1
      @amol.mailbox.messages.first.body.should == "Sent Message"
    end
    
    it "should assign multiple users from to list" do
      message = Factory.build(:message, from: @greg, to: [@amol, @reid, @zac], body: "Sent Message")
      
      message_assigner = MessageUserAssigner.new(message)
      message_assigner.assign_message_to_users()
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.body.should == "Sent Message"
      
      @amol.mailbox.messages.size.should == 1
      @amol.mailbox.messages.first.body.should == "Sent Message"
      
      @zac.mailbox.messages.size.should == 1
      @zac.mailbox.messages.first.body.should == "Sent Message"
      
      @reid.mailbox.messages.size.should == 1
      @reid.mailbox.messages.first.body.should == "Sent Message"
    end
    
    it "should not send 2 messages when message is addressed to self" do
      message = Factory.build(:message, from: @greg, to: [@greg], body: "Sent Message")
      
      message_assigner = MessageUserAssigner.new(message)
      message_assigner.assign_message_to_users()
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.body.should == "Sent Message"
    end
    
    it "should not send 2 messages when message is addressed to person twice" do
      message = Factory.build(:message, from: @greg, to: [@reid, @reid], body: "Sent Message")
      
      message_assigner = MessageUserAssigner.new(message)
      message_assigner.assign_message_to_users()
      
      @reid.mailbox.messages.size.should == 1
      @reid.mailbox.messages.first.body.should == "Sent Message"
    end
  end
end