require 'spec_helper'

describe UserLikeLocator do
  before(:each) do
    @user_personality = Factory.build(:user_personality)
    @user_locator = UserLikeLocator.new(@user_personality)
  end
  describe "locating user" do
    it "should find like" do
      @user_personality.likes << Factory.build(:like, :name => "swimming")
      @user_personality.likes << Factory.build(:like, :name => "running")
      @user_personality.likes << Factory.build(:like, :name => "dancing")

      @user_locator.find_like("swimming").should_not == nil
      @user_locator.find_like("running").should_not == nil
      @user_locator.find_like("dancing").should_not == nil
    end
    
    it "should return nil if like is not found" do      
      @user_locator.find_like("running").should == nil
    end    
  end
end