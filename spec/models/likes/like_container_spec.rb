require 'spec_helper'

describe LikeContainer do  
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
      
      user_like_container = LikeContainer.new(like_array)
      
      mock_visitor = MockLikeVisitor.new
      like_names = user_like_container.accept_like_visitor(mock_visitor)
      mock_visitor.likes_visited.should =~ like_array
    end
  end
end