require 'spec_helper'

describe Recommender do
  before(:each) do
    @user = Factory(:user)
    @recommender = Recommender.new()
  end
  
  describe "creating random like recommendations" do
    before (:each) do
      (1..20).each do
        Factory(:like)
      end
    end
    
    it "should create n likes when give random generator" do
      random_generator = RandomLikeRecommendationGenerator.new(@user)
      @recommender.get_recommendations(random_generator, 5).size.should == 5
    end
  end
  
end