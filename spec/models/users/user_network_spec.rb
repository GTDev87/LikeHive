require 'spec_helper'

describe UserNetwork do
  describe "User Network" do
    it "should be valid if user is valid" do
      user = Factory.build(:user)
      invalid_user_network = Factory.build(:user_network, contacts: [user])
    
      invalid_user_network.should be_valid
    end
    
    it "should not be valid if user is not valid" do
      user = Factory.build(:user, profile: nil)
      invalid_user_network = Factory.build(:user_network, contacts: [user])
    
      invalid_user_network.should_not be_valid
    end
  end
end