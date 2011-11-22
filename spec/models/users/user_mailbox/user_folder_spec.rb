require 'spec_helper'

describe UserFolder do  
  describe "User folder" do    
    it "should have all incoming messages" do
      messages = []
      5.times do
        messages << Factory.build(:connection_message, message_data: Factory.build(:message_data, :to => [Factory.build(:user)]))
      end
      user_folder = UserFolder.new(messages)

      user_folder.container.messages.should =~ messages
    end
  end
end