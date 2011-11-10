require 'spec_helper'

describe UserFolder do  
  describe "User folder" do    
    it "should have all incoming messages" do
      messages = []
      5.times do
        messages << Factory.build(:message, :to => [Factory.build(:user)])
      end
      user_folder = UserFolder.new(messages)

      user_folder.container.messages.should =~ messages
    end
  end
end