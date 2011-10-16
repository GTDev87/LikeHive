require 'spec_helper'

describe UserCreator do  
  describe "Creating Users" do
    it "should create a user when new is called" do
      UserCreator.new
      User.count.should == 0
    end
    
    it "should have all embedded parts" do
      user = UserCreator.new
      user.profile.should_not be_nil
      user.profile.name.should_not be_nil
      user.profile.age.should_not be_nil
      user.profile.gender.should_not be_nil
      user.residence.should_not be_nil
      user.personality.should_not be_nil
    end
  end
end