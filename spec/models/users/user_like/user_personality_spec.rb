require 'spec_helper'

describe UserPersonality do  
  before(:each) do
    @user_personality = Factory.build(:user_personality)
  end  

  describe "Finding likes" do
    it "should find like if exists" do
      @user_personality.likes << Factory.build(:like, :name => "Pizza")
      @user_personality.find_like("pizza").should_not be_nil
    end
  end
  
  describe "Adding likes" do
    it "should add a like if it does not exist" do
      likes = @user_personality.get_new_like("New Like")
      
      likes.name.should == "new like"
    end
  end
  
  describe "Adding multiple likes" do    
    it "should be able to accept likes and find likes" do
      likes = @user_personality.get_new_likes(" food, cheese , stars ")
      
      likes.should contain_result_named("food")
      likes.should contain_result_named("stars")
      likes.should contain_result_named("cheese")
      likes.size.should == 3
    end
  end
end