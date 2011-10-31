require 'spec_helper'

describe UserMailbox do  
  describe "User messages" do    
    it "should be valid with valid message" do
      user_mailbox = Factory.build(:user_mailbox)
      message = Factory.build(:message)
      message.to << Factory.build(:user)
      user_mailbox.messages << message
      
      user_mailbox.should be_valid
    end
    
    it "should be invalid with invalid message added" do
      user_mailbox = Factory.build(:user_mailbox)
      user_mailbox.messages << Factory.build(:message) 
      user_mailbox.should_not be_valid
    end
    
    it "should add message to user mailbox" do
      user_mailbox = Factory.build(:user_mailbox)
      user_mailbox.messages << Factory.build(:message) 
      
      user_mailbox.messages.size.should == 1
    end
  end
  
  
end