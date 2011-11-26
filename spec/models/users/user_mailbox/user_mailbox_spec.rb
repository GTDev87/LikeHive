require 'spec_helper'

describe UserMailbox do  
  describe "User messages validation" do    
    it "should be valid with valid message" do
      user_mailbox = Factory.build(:user_mailbox)
      message = Factory.build(:contact_message, message_data: Factory.build(:message_data, :to => [Factory.build(:user)]))
      
      user_mailbox.should be_valid
    end
    
    it "should be invalid with invalid message added" do
      user_mailbox = Factory.build(:user_mailbox)
      user_mailbox.messages << Factory.build(:contact_message) 
      user_mailbox.should_not be_valid
    end
    
    it "should add message to user mailbox" do
      user_mailbox = Factory.build(:user_mailbox)
      user_mailbox.messages << Factory.build(:contact_message) 
      
      user_mailbox.messages.size.should == 1
    end
  end
  
  describe "Inbox/Outbox creation" do
    before(:each) do
      @user = Factory.build(:user)
      @user_email = @user.email
      @user_mailbox = @user.mailbox
      @message_inbox_a = Factory.build(:contact_message, message_data: Factory.build(:message_data, to: [@user]))
      @message_inbox_b = Factory.build(:contact_message, message_data: Factory.build(:message_data, to: [@user, Factory.build(:user)]))
      @message_inbox_c = Factory.build(:contact_message, message_data: Factory.build(:message_data, to: [@user, @user]))
      
      @message_outbox_a = Factory.build(:contact_message, message_data: Factory.build(:message_data, :from => @user, to: [Factory.build(:user)]))
      
      @message_inbox_outbox_a = Factory.build(:contact_message, message_data: Factory.build(:message_data, to: [@user], from: @user))
      @message_inbox_outbox_b = Factory.build(:contact_message, message_data: Factory.build(:message_data, to: [@user, Factory.build(:user)], from: @user))

      @message_irrelevant = Factory.build(:contact_message, message_data: Factory.build(:message_data, to: [Factory.build(:user)], from: Factory.build(:user)))
    
      @user_mailbox.messages.concat([@message_inbox_a, @message_inbox_b, @message_inbox_c, @message_outbox_a, @message_inbox_outbox_a, @message_inbox_outbox_b, @message_irrelevant])  
    end
    
    it "should put messages into inbox" do
      @user_mailbox.setup_mailbox_folders
      
      @user_mailbox.inbox.container.messages.should =~ [@message_inbox_a, @message_inbox_b, @message_inbox_c, @message_inbox_outbox_a, @message_inbox_outbox_b]
    end
     
    it "should put messages into outbox" do
      @user_mailbox.setup_mailbox_folders
      
      @user_mailbox.outbox.container.messages.should =~ [@message_outbox_a, @message_inbox_outbox_a, @message_inbox_outbox_b]
    end
  end
end