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
  end
end