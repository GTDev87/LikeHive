require 'spec_helper'

describe UserInterests do  
  before(:each) do    
    @user = Factory(:user)
    @userAdder = UserInterestAdder.new(@user)
    @userLocator = UserInterestLocator.new(@user)
    @userInterests = UserInterests.new(@user, @userLocator, @userAdder)
    
    @user2 = Factory(:user)
    @userAdder2 = UserInterestAdder.new(@user2)
    @userLocator2 = UserInterestLocator.new(@user2)
    @userInterests2 = UserInterests.new(@user2, @userLocator2, @userAdder2)
  end  

  describe "Adding single likes" do
    
    it "should have no likes on creation" do
      @userInterests.num_likes == 0
    end
      
    it "should be able to accept likes" do
      @userInterests.add_like("Pizza")
      @userInterests.add_like("Breadsticks")
      @userInterests.find_like("pizza").should_not be_nil
      @userInterests.find_like("breadsticks").should_not be_nil
    end
    
    it "should keep track of number of likes" do
      @userInterests.add_like("Pizza")
      @userInterests.add_like("Breadsticks")
      @userInterests.num_likes.should == 2
    end
    
    it "should not find non-existant likes" do
      @userInterests.add_like("Parkour")
      @userInterests.find_like("running").should be_nil
    end    
    
    it "should not double count likes" do
      @userInterests.add_like("Cats")
      @userInterests.add_like("Cats")
      @userInterests.find_like("cats").should_not be_nil
      @userInterests.num_likes.should == 1
    end
    
    it "should not add empty likes" do
      @userInterests.add_like("")
      @userInterests.find_like("").should be_nil
      @userInterests.num_likes.should == 0
    end
    
    it "should not add blank likes" do
      @userInterests.add_like(" ")
      @userInterests.find_like(" ").should be_nil
      @userInterests.num_likes.should == 0
    end    
  end
  
  describe "Adding likes to database behavior" do
    it "should add a like if it does not exist" do
      @userInterests.add_like("New Like")
      Like.count.should == 1
    end
    
    it "should not add a like to database if already exist" do
      @userInterests.add_like("New Like")
      @userInterests2.add_like("New Like")
      Like.count.should == 1
    end
  end
  
  describe "Adding multiple likes" do
    it "should be able to accept multiple comma delimited likes" do
      @userInterests.add_multiple_likes("Pizza, Breadsticks")
      @userInterests.find_like("pizza").should_not be_nil
      @userInterests.find_like("breadsticks").should_not be_nil
      @userInterests.num_likes.should == 2
    end
    
    it "should be able to accept case insensitive likes" do
      @userInterests.add_multiple_likes("TeLeViSiOn")
      @userInterests.find_like("television").should_not be_nil
      @userInterests.num_likes.should == 1
    end
    
    it "should be able to accept like ignoring leading and ending spaces" do
      @userInterests.add_multiple_likes(" food, cheese , stars ")
      @userInterests.find_like("food").should_not be_nil
      @userInterests.find_like("stars").should_not be_nil
      @userInterests.find_like("cheese").should_not be_nil
      @userInterests.num_likes.should == 3
    end
    
    it "should be able to accept multiple, multiple word comma delimited likes" do
      @userInterests.add_multiple_likes("red fish, blue fish")
      @userInterests.find_like("red fish").should_not be_nil
      @userInterests.find_like("blue fish").should_not be_nil
      @userInterests.num_likes.should == 2
    end
    
    it "should not accept empty likes" do
      @userInterests.add_multiple_likes("")
      @userInterests.find_like("").should be_nil
      @userInterests.num_likes.should == 0
    end
    
    it "should not accept blank likes" do
      @userInterests.add_multiple_likes(" ")
      @userInterests.find_like(" ").should be_nil
      @userInterests.num_likes.should == 0
    end
  end
end