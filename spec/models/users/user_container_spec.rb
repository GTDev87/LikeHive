require 'spec_helper'

describe UserContainer do  
  describe "getting all users" do
    
    class MockUserVisitor
      attr_reader :users_visited
      def initialize()
        @users_visited = []
      end
      def visit_user(user)
        @users_visited << user
      end
    end
    
    it "should let visitor visit all users" do
      user_array = []
      user_array << Factory.build(:user, :email => "greg@test.com")
      user_array << Factory.build(:user, :email => "amol@test.com")
      user_array << Factory.build(:user, :email => "reid@test.com")
      user_array << Factory.build(:user, :email => "deepak@test.com")
      
      user_container = UserContainer.new(user_array)
      
      mock_visitor = MockUserVisitor.new
      user_names = user_container.accept_user_visitor(mock_visitor)
      mock_visitor.users_visited.should =~ user_array
    end
  end
end