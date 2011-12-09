require 'spec_helper'

describe UserRecommendationInteraction do
  describe "Recommending users" do
    before(:each) do
      @user = Factory.build(:user)
    end
    it "should visit each user when called to" do
      @user_array = []
      5.times do
        @user_array << Factory.build(:user)
      end
      interaction = UserRecommendationInteraction.new(@user)
      @user_array.each do |user|
        interaction.visit(user)
      end
      
      found_users = []
      interaction.user_links.each do |peek|
        found_users << peek.other_user
      end
      
      @user_array.should =~ found_users
    end
    
    it "should find similar likes when it visits" do
      interaction = UserRecommendationInteraction.new(@user)
      pizza = Factory.build(:like, :name => "pizza")
      
      @user.personality.likes << pizza
      
      recommended_user = Factory.build(:user)
      recommended_user.personality.likes << pizza
      
      interaction.visit(recommended_user)
      
      interaction.user_links.each do |peek|
        peek.similar_likes.should == [pizza]
      end
    end
  end
end