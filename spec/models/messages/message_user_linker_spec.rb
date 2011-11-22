require 'spec_helper'

describe MessageUserLinker do  
  describe "linking users to messages" do
    before(:each) do
      @greg = Factory.build(:user, email: "greg@test.com")
      @amol = Factory.build(:user, email: "amol@test.com")
      @zac = Factory.build(:user, email: "zac@test.com")
      @reid = Factory.build(:user, email: "reid@test.com")
    end
    
    it "should link message to user" do
      message_user_linker = MessageUserLinker.new()
      
      message = Factory.build(:connection_message, message_data: Factory.build(:message_data, to: [@greg], body: "Sent Message"))
      message_user_linker.link_user_and_message(@greg, message)
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.message_data.body.should == "Sent Message"
    end
  end
end