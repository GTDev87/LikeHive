require 'spec_helper'

describe UserLikeLinker do
  before(:each) do
    @user = Factory.build(:user)
    @like = Factory.build(:like)
  end
  
  describe "adding like to user" do
    it "should not add like to a user if user is nil" do
      UserLikeLinker.link_user_and_like(nil, @like)
      @like.following.users.size.should == 0
    end
    
    it "should add like to a user list" do
      UserLikeLinker.link_user_and_like(@user, @like)
      @like.following.users.size.should == 1
    end
  end
  
  describe "adding user to like" do
    it "should not add a like to user if like is nil" do
      UserLikeLinker.link_user_and_like(@user, nil)
      @user.personality.likes.size.should == 0
    end
    
    it "should add like to a user list" do
      UserLikeLinker.link_user_and_like(@user, @like)
      @user.personality.likes.size.should == 1
    end
  end
end