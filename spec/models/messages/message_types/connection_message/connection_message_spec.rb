require 'spec_helper'

describe ConnectionMessage do  
  
  describe "Connection message properties" do
    it "should have type ConnectionMessage" do      
      user = Factory.build(:user)
      connection_message = Factory(:connection_message, message_data: Factory.build(:message_data, to: [user]))
    
      connection_message._type.should == "ConnectionMessage"
    end
  end
  
  describe "To username parsing" do
    before(:each) do
      @greg = Factory(:user, username: "GregT")
      @reid = Factory(:user, username: "ReidH")
      @amol = Factory(:user, username: "AmolK")
      @zac = Factory(:user, username: "ZacC")
    end
        
    it "should add existing users to to list" do
      message = Factory.build(:connection_message)
      message.to_username_list = "GregT, ReidH, AmolK, ZacC"
      message.save!
      
      message.message_data.to.size.should == 4
    end
    
    it "should parse usernames before validation" do
      message = Factory.build(:connection_message)
      message.to_username_list = "GregT, ReidH, AmolK, ZacC"

      message.should be_valid
    end
    
    it "should parse usernames before save" do
      message = Factory.build(:connection_message)
      message.to_username_list = "GregT, ReidH, AmolK, ZacC"
      message.save!
      
      message.should be_valid
    end
        
    it "should not be valid if list is empty" do
      message = Factory.build(:connection_message)
      message.to_username_list = ""
      
      message.should_not be_valid
    end
    
    it "should not be valid if does not recognize any user" do
      message = Factory.build(:connection_message)
      message.to_username_list = "A, B, C, D"
      
      message.should_not be_valid
      message.message_data.to.size.should == 0
    end
  end
  describe "users receiving messages" do
    before(:each) do
      @greg = Factory(:user, username: "GregT")
      @reid = Factory(:user, username: "ReidH")
      @amol = Factory(:user, username: "AmolK")
      @zac = Factory(:user, username: "ZacC")
    end
    
    it "should give message to a user it is sent to after save" do
      message = Factory.build(:connection_message)
      message.message_data.body = "sent message"
      message.to_username_list = "GregT"
      message.save!
      
      @greg.reload
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.message_data.body.should == "sent message"
    end
    
    it "should give message to multiple user it is sent to after save" do
      message = Factory.build(:connection_message)
      message.message_data.body = "sent message"
      message.to_username_list = "GregT, ReidH, AmolK, ZacC"
      message.save!
      
      @greg.reload
      @reid.reload
      @amol.reload
      @zac.reload
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.message_data.body.should == "sent message"
      
      @reid.mailbox.messages.size.should == 1
      @reid.mailbox.messages.first.message_data.body.should == "sent message"
      
      @amol.mailbox.messages.size.should == 1
      @amol.mailbox.messages.first.message_data.body.should == "sent message"
      
      @zac.mailbox.messages.size.should == 1
      @zac.mailbox.messages.first.message_data.body.should == "sent message"
    end
    
    it "should give message to a user it is sent from after save" do
      message = Factory.build(:connection_message)
      message.message_data.body = "sent message"
      message.message_data.from = @greg
      message.to_username_list = "AmolK"
      message.save!
      
      @greg.reload
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.message_data.body.should == "sent message"
    end
    
    it "should be able to give multiple messages to users" do
      message = Factory.build(:connection_message)
      message.message_data.body = "sent message 1"
      message.to_username_list = "GregT"
      message.save!
      
      message2 = Factory.build(:connection_message)
      message2.message_data.body = "sent message 2"
      message2.to_username_list = "GregT"
      message2.save!
      
      @greg.reload
      
      @greg.mailbox.messages.size.should == 2
      @greg.mailbox.messages.first.message_data.body.should == "sent message 1"
      @greg.mailbox.messages.last.message_data.body.should == "sent message 2"
    end
  end
end