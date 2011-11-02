require 'spec_helper'

describe UserLikeLocator do
  before(:each) do
    @like_array = []
    @user_like_container = UserLikeContainer.new(@like_array)
    @user_locator = UserLikeLocator.new(@user_like_container)
  end
  describe "locating user" do
    it "should find like" do
      @like_array << Factory.build(:like, :name => "swimming")
      @like_array << Factory.build(:like, :name => "running")
      @like_array << Factory.build(:like, :name => "dancing")

      @user_locator.find_like("swimming").should_not == nil
      @user_locator.find_like("running").should_not == nil
      @user_locator.find_like("dancing").should_not == nil
    end
    
    it "should return nil if like is not found" do      
      @user_locator.find_like("running").should == nil
    end    
  end
end