require 'spec_helper'

describe UserInterestLocator do
  before(:each) do
    @user = Factory(:user)
    @userLocator = UserInterestLocator.new(@user)
    @userAdder = UserInterestAdder.new(@user)
  end
  describe "locating user" do
    it "should find like" do
      @userAdder.add_interest("swimming")
      @userAdder.add_interest("running")
      @userAdder.add_interest("dancing")
      @userLocator.find_like("swimming").should_not == nil
      @userLocator.find_like("running").should_not == nil
      @userLocator.find_like("dancing").should_not == nil
    end
    
    it "should return nil if like is not found" do
      @userAdder.add_interest("swimming")
      @userLocator.find_like("running").should == nil
    end
    
    it "should return likes are not initialized" do
      @user.likes = nil
      @userLocator.find_like("running").should == nil
    end
  end
end