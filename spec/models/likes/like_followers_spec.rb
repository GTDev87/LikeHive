require 'spec_helper'

describe Like do  
  describe "users_followers_count" do
    before(:each) do
      @like = Factory(:like)
      @likeFollowers = @like.get_followers
    end
    
    it "should keep track of users which like it" do
      @likeFollowers << Factory(:user)
      @likeFollowers.num_users.should == 1
    end
    
    it "should start with no likers" do
      @likeFollowers.num_users.should == 0
    end
    
    it "should keep track of users when added to a user" do
      Factory(:user).likes << @like
      @likeFollowers.num_users == 1
    end
  end
end