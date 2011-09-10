require 'spec_helper'

describe Like do
  before(:each) do
    @attr = { 
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  describe "users_followers_count" do
    before(:each) do
      @like = Like.create!(:name => "ketchup")
      @likeFollowers = @like.get_followers
    end
    
    it "should keep track of users which like it" do
      @likeFollowers << User.create(@attr)
      @likeFollowers.num_users.should == 1
    end
    
    it "should start with no likers" do
      @likeFollowers.num_users.should == 0
    end
    
    it "should keep track of users when added to a user" do
      user = User.create(@attr)
      user.likes << @like
      @likeFollowers.num_users == 1
    end
  end
  
  describe "displaying users" do
    before(:each) do
      @like = Like.create!(:name => "ketchup")
      @likeFollowers = @like.get_followers
    end
    
    it "should return No Users if no users exist" do
      @likeFollowers.return_user_names.should == ["No Users"]
    end
    
    it "should return user if like has a user" do
      @like.users << User.create(
      :name => "Greg",
      :email => "greg@example.com",
      :password => "foobar",
      :password_confirmation => "foobar")
      @likeFollowers.return_user_names.should == ["Greg"]
    end
  end
end