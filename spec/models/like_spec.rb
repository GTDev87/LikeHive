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
  
  describe "name" do
    it "should create a like using a capitalized name" do
      pizza = Like.create!(:like_name => "pizza")
      pizza.like_name.should == "Pizza"
    end
  
    it "should create a like using a capitalized name with multiple words" do
      pizza = Like.create!(:like_name => "PEPPERONNI pizza")
      pizza.like_name.should == "Pepperonni Pizza"
    end
  end
  
  describe "users" do
    before(:each) do
      @like = Like.create!(:like_name => "ketchup")
    end
    
    it "should keep track of users which like it" do
      @like.users << User.create(@attr)
      @like.save!
      @like.num_users.should == 1
    end
    
    it "should start with no likers" do
      @like.num_users.should == 0
    end
    
    it "should keep track of users when added to a user" do
      user = User.create(@attr)
      user.likes << @like
      @like.num_users == 1
    end
  end
end
