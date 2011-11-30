require 'spec_helper'

require "cancan/matchers"

# ...
#ability.should be_able_to(:destroy, Project.new(:user => user))
#ability.should_not be_able_to(:destroy, Project.new)

describe Ability do  
  describe "User's Abilities on user's page" do
    before(:each) do
      @user = Factory(:user)
      @ability = Ability.new(@user)
    end
    
    it "should have ability to read own page" do
      @ability.should be_able_to(:read, @user)
    end
    
    it "should not have the ability to read nil users page" do
      user = nil
      ability = Ability.new(user)
      ability.should_not be_able_to(:read, user)
    end
    
    it "should not have ability to read other user's page" do
      @ability.should_not be_able_to(:read, Factory(:user))
    end
  end
  
  describe "User's Abilities on message's page" do
    before(:each) do
      @sending_user = Factory(:user, username: "Sendy")
      @receiving_user = Factory(:user, username: "Receivy")
      @sending_user.network.contacts << @receiving_user
      @receiving_user.network.contacts << @sending_user
      @message = Factory(:contact_message, message_data: Factory.build(:message_data, to: [@receiving_user], from: @sending_user))
    end
    
    it "should have ability to read message sent to user" do
      @ability = Ability.new(@sending_user)
      
      @ability.should be_able_to(:read, @message)
    end
    
    it "should have ability to read message sent from user" do
      @ability = Ability.new(@receiving_user)

      @ability.should be_able_to(:read, @message)
    end
    
    it "should not have ability to read message not from or to user" do
      @ability = Ability.new(Factory(:user))

      @ability.should_not be_able_to(:read, @message)
    end
  end
end