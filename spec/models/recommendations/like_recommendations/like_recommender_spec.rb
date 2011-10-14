require 'spec_helper'

describe LikeRecommender do
  before(:each) do
    @user = Factory(:user)
    @recommender = LikeRecommender.new()
  end
  
  describe "creating random likes" do
    before (:each) do
      (1..20).each do
        Factory(:like)
      end
    end
    
    it "should create n likes when give random generator" do
      random_generator = RandomLikeRecommendationGenerator.new(@user)
      @recommender.recommend_interests(random_generator, 5).size.should == 5
    end
  end
  
end