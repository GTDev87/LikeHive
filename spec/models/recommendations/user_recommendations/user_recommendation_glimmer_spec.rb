require 'spec_helper'

describe UserRecommendationGlimmer do
  describe "Recommending users" do
    before(:each) do
      @user = Factory.build(:user)
    end
    it "should visit each user when called to" do
      @user_array = []
      5.times do
        @user_array << Factory.build(:user)
      end
      glimmer = UserRecommendationGlimmer.new(@user)
      @user_array.each do |user|
        glimmer.visit(user)
      end
      
      found_users = []
      glimmer.user_peeks.each do |peek|
        found_users << peek.user
      end
      
      @user_array.should =~ found_users
    end
    
    it "should find similar likes when it visits" do
      glimmer = UserRecommendationGlimmer.new(@user)
      pizza = Factory.build(:like, :name => "pizza")
      
      @user.personality.likes << pizza
      
      recommended_user = Factory.build(:user)
      recommended_user.personality.likes << pizza
      
      glimmer.visit(recommended_user)
      
      glimmer.user_peeks.each do |peek|
        peek.similar_likes.should == [pizza]
      end
    end
  end
end