require 'spec_helper'

describe UserOutgoingMessageVisitor do  
  describe "visit outgoing messages" do    
    before(:each) do
      @user = Factory.build(:user)
      @user_outgoing_visitor = UserOutgoingMessageVisitor.new(@user)
    end
    
    it "should visit outgoing message" do      
      outgoing_message = Factory.build(:connection_message, message_data: Factory.build(:message_data, :from => @user))
      
      @user_outgoing_visitor.visit_message(outgoing_message)
      @user_outgoing_visitor.outgoing_messages.should == [outgoing_message]
    end    
    
    it "should not visit not outgoing message" do
      not_outgoing_message = Factory.build(:connection_message, message_data: Factory.build(:message_data, :from => Factory.build(:user)))
      
      @user_outgoing_visitor.visit_message(not_outgoing_message)
      @user_outgoing_visitor.outgoing_messages.should == []
    end
    
    it "should find all of the outgoing messages" do
      message_array = []
      outgoing_messages = []
      
      5.times do
        outgoing_messages << Factory.build(:connection_message, message_data: Factory.build(:message_data, :from => @user))
        message_array << Factory.build(:connection_message, message_data: Factory.build(:message_data, :from => Factory.build(:user)))
      end
      message_array.concat(outgoing_messages)
      
      user_container = UserMessageContainer.new(message_array)
      user_container.accept_message_visitor(@user_outgoing_visitor)
      
      @user_outgoing_visitor.outgoing_messages.should =~ outgoing_messages
    end
  end
end