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
  
  describe "Getting All Like Names" do
    
    class MockLikeVisitor
      attr_reader :likes_visited
      def initialize()
        @likes_visited = []
      end
      def continue_visit_like(like)
        @likes_visited << like
      end
    end
    
    it "should let visitor visit all likes" do
      like_array = []
      like_array << Factory.build(:like, :name => "Pizza")
      like_array << Factory.build(:like, :name => "Fish")
      like_array << Factory.build(:like, :name => "French Fries")
      like_array << Factory.build(:like, :name => "Cheese")
    
      @user_personality.likes.concat(like_array)
      
      mock_visitor = MockLikeVisitor.new
      like_names = @user_personality.accept_like_visitor(mock_visitor)
      mock_visitor.likes_visited.should =~ like_array
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