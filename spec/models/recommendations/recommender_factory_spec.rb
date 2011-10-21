require 'spec_helper'

describe RecommenderFactory do
  before(:each) do
    @user = Factory(:user)
  end
  describe "creating like recommender" do
    it "should create a recommender when passed like generator" do      
      recommender = RecommenderFactory.create_recommender(RandomLikeRecommendationGenerator.new(@user))
      recommender.class.should be(Recommender)
    end
  end
end