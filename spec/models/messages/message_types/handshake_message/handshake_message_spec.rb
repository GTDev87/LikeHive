require 'spec_helper'

describe HandshakeMessage do  
  describe "Validating Handshakes Messages" do    
    it "should require non empty handshake to" do
      handshake = Factory.build(:handshake_message, message_data: Factory.build(:message_data, to: []))
    
      handshake.should_not be_valid
    end
    
    it "should have handshake as type" do
      user = Factory.build(:user)
      handshake = Factory(:handshake_message, message_data: Factory.build(:message_data, to: [user]))
    
      handshake._type.should == "HandshakeMessage"
    end
    
    describe "sending virtual handshake" do
      before(:each) do
        @user_1 = Factory(:user)
        @user_2 = Factory(:user)
        @user_3 = Factory(:user)
      end
    
      it "should create handshake when saved" do
        handshake_1 = Factory.build(:handshake_message, message_data: Factory.build(:message_data, from: @user_1, to: [@user_2]))
        handshake_1.save!
  
        handshake_2 = Factory.build(:handshake_message, message_data: Factory.build(:message_data, from: @user_1, to: [@user_3]))
        handshake_2.save!
        
        @user_1.reload
        @user_2.reload
        @user_3.reload
      
        @user_1.mailbox.messages.first.message_data.from.should == @user_1
        @user_1.mailbox.messages.first.message_data.to.should == [@user_2]
      
        @user_1.mailbox.messages.last.message_data.from.should == @user_1
        @user_1.mailbox.messages.last.message_data.to.should == [@user_3]
      
        @user_2.mailbox.messages.first.message_data.from.should == @user_1
        @user_2.mailbox.messages.first.message_data.to.should == [@user_2]
      
        @user_3.mailbox.messages.first.message_data.from.should == @user_1
        @user_3.mailbox.messages.first.message_data.to.should == [@user_3]
      end
    end
  end
end