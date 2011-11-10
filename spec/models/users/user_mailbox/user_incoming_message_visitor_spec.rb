require 'spec_helper'

describe UserIncomingMessageVisitor do
  describe "visit incoming messages" do
    before(:each) do
      @user = Factory.build(:user)
      @user_incoming_visitor = UserIncomingMessageVisitor.new(@user)
    end
    
    it "should visit incoming message" do      
      incoming_message = Factory.build(:message, :to => [@user])
      
      @user_incoming_visitor.visit_message(incoming_message)
      @user_incoming_visitor.incoming_messages.should == [incoming_message]
    end
    
    it "should visit incoming message sent to multiple users" do      
      incoming_message = Factory.build(:message, :to => [@user, Factory.build(:user)])
      
      @user_incoming_visitor.visit_message(incoming_message)
      @user_incoming_visitor.incoming_messages.should == [incoming_message]
    end
    
    it "should not visit not incoming message" do
      not_incoming_message = Factory.build(:message, :to => [Factory.build(:user)])
      
      @user_incoming_visitor.visit_message(not_incoming_message)
      @user_incoming_visitor.incoming_messages.should == []
    end
    
    it "should find all of the incoming messages" do
      message_array = []
      incoming_messages = []
      
      5.times do
        incoming_messages << Factory.build(:message, :to => [@user])
        message_array << Factory.build(:message, :to => [Factory.build(:user)])
      end
      message_array.concat(incoming_messages)
      
      user_container = UserMessageContainer.new(message_array)
      user_container.accept_message_visitor(@user_incoming_visitor)
      
      @user_incoming_visitor.incoming_messages.should =~ incoming_messages
    end
  end
end