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
    
    it "should not have ability to read other user's page" do
      @ability.should_not be_able_to(:read, Factory(:user))
    end
  end
  
  describe "User's Abilities on message's page" do
    before(:each) do
      @user = Factory(:user)
      @ability = Ability.new(@user)
    end
    
    it "should have ability to read message sent to user" do
      message = Factory(:message, to: [@user], from: Factory(:user) )
      @ability.should be_able_to(:read, message)
    end
    
    it "should have ability to read message sent from user" do
      message = Factory(:message, to: [Factory(:user)], from: @user )
      @ability.should be_able_to(:read, message)
    end
    
    it "should not have ability to read message not from or to user" do
      message = Factory(:message, to: [Factory(:user)], from: Factory(:user))
      @ability.should_not be_able_to(:read, message)
    end
  end
end