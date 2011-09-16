require 'spec_helper'

describe UserInterestAdder do
  before(:each) do
    @user = Factory(:user)
    @userLocator = UserInterestLocator.new(@user)
    @userAdder = UserInterestAdder.new(@user)
  end
  describe "adding user" do
    it "should create a user when new is called" do
      @userAdder.add_interest("Swimming")
      @userLocator.find_like("swimming").should_not == nil
    end
    
    it "should add to num likes" do
      @userAdder.add_interest("Swimming")
      Like.count.should == 1
    end
    
    it "should add to num likes for user" do
      @userAdder.add_interest("Swimming")
      @user.num_likes.should == 1
    end
    
    it "should not add like if already exists" do
      @userAdder.add_interest("Swimming")
      @userAdder.add_interest("Swimming")
      @user.num_likes.should == 1
      Like.count.should == 1
    end
    
    it "should ignore capitalization" do
      @userAdder.add_interest("SwImMiNg")
      @userLocator.find_like("swimming").should_not be_nil
    end
    
    it "should ignore leading end ending space" do
      @userAdder.add_interest(" dogs")
      @userAdder.add_interest("cats ")
      @userLocator.find_like("dogs").should_not be_nil
      @userLocator.find_like("cats").should_not be_nil
      Like.count.should == 2
    end
  end
end