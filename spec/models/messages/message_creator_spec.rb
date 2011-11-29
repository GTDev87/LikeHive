require 'spec_helper'

describe MessageCreator do  
  describe "Creating Messages" do
    it "should create a contact message when new is called" do
      message = MessageCreator.new_contact_message()

      message._type.should == "ContactMessage"
    end
    
    it "should create a contact message when new is called with parameters" do
      params = {}
      message = MessageCreator.new_contact_message_with_parameters(params)

      message._type.should == "ContactMessage"
    end
    
    it "should create handshake message when new is called" do
      message = MessageCreator.new_handshake_message
      
      message._type.should == "HandshakeMessage"
    end
    
    it "should create a handshake message when new is called with parameters" do
      params = {}
      message = MessageCreator.new_handshake_message_with_parameters(params)

      message._type.should == "HandshakeMessage"
    end
    
    it "should create a handshake acceptance message" do
      greg = Factory.build(:user, username: "Greg")
      reid = Factory.build(:user, username: "Reid")
      message = MessageCreator.create_accept_message(greg, reid)
      
      message._type.should == "ContactMessage"
      message.message_data.to.should == [reid]
      message.message_data.from.should == greg
      message.message_data.subject.should == "[Handshake Accepted] #{greg.username}"
    end
  end
end