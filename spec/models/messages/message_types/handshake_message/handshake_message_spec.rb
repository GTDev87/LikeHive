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
  end
end