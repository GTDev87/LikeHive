require 'spec_helper'

describe UserRecommendation do
  describe "Returning recommendations" do
    before(:each) do
      @user_list = [Factory.build(:user, 
        :profile => Factory.build(:user_profile, 
        :name => Factory.build(:user_name, 
        :first => "Reid"))), 
        Factory.build(:user, 
        :profile => Factory.build(:user_profile, 
        :name => Factory.build(:user_name, 
        :first => "Greg")))]
      @recommendation = UserRecommendation.new(@user_list)      
    end
    it "should return list through reader" do
      @recommendation.user_list =~ @user_list
    end
    
    class MockVisitor
      attr_accessor :list
      def initialize()
        @list = []
      end
      def visit(user)
        @list << user
      end
    end
    
    it "should accept visitor and iterate through all in list" do
      mock_visitor = MockVisitor.new()
      @recommendation.accept(mock_visitor)
      mock_visitor.list.should =~ @user_list
    end
  end
end