require 'spec_helper'

describe Recommender do
  describe "creating random like recommendations" do
    before (:each) do
      7.times.each do
        Factory(:like)
      end
    end
    
    it "should create n likes when give random generator" do
      user = Factory(:user)
      random_generator = RandomLikeRecommendationGenerator.new(user)
      recommender = Recommender.new(random_generator)
      recommender.get_recommendations(5).size.should == 5
    end
  end
  
  describe "creating random user recommendations" do
    before (:each) do
      7.times.each do
        Factory(:user)
      end
    end
    
    it "should create n user when give random generator" do
      user = Factory(:user)
      random_generator = RandomUserRecommendationGenerator.new(user)
      recommender = Recommender.new(random_generator)
      recommender.get_recommendations(5).size.should == 5
    end
  end
  
end