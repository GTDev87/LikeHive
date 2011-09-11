require 'spec_helper'

describe UserInterests do  
  before(:each) do
    @attr = { 
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  def has_like?(like_name)
    @user.likes.each do |like|
      if like.name == like_name
        return true
      end
    end
    return false
  end

  describe "Interest Data" do
    before(:each) do
      @user = User.create!(@attr)
      @userInterests = @user.get_likes
    end
    
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
    
    it "should be converted to lowercase format" do
      @userInterests.add_like("dOgS")
      @userInterests.find_like("dogs").should_not be_nil
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
  
  describe "Finding Like Names" do
    before(:each) do
      @user = User.create!(@attr)
      @userInterests = @user.get_likes
    end
    
    it "should return no likes when the user has no likes" do
      @userInterests.return_like_names.should == ["No Likes"]
    end
    
    it "should display all likes added" do
      @userInterests.add_like("Pizza")
      @userInterests.add_like("BreadSticks")
      @userInterests.return_like_names.should == ["breadsticks", "pizza"]
    end
    
    it "should display likes lowercase" do
      @userInterests.add_like("LOWERCASE")
      @userInterests.return_like_names.should == ["lowercase"]
    end
    
    it "should display all likes in alphabetical order" do
      @userInterests.add_like("e")
      @userInterests.add_like("c")
      @userInterests.add_like("d")
      @userInterests.add_like("b")
      @userInterests.add_like("a")
      @userInterests.return_like_names.should == ["a", "b", "c" ,"d", "e"]
    end
  end
end