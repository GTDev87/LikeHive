require 'spec_helper'

describe LikeFollowing do
  before(:each) do    
    @like_following = Factory.build(:like_following)
  end
  describe "add users" do
    it "should have no user followers when created" do
      @like_following.users.size.should == 0
    end
    
    it "should add users to the following" do
      @like_following.users << Factory.build(:user)
      
      @like_following.users.size.should == 1
    end
  end
end