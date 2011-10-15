require 'spec_helper'

describe RandomUserRecommendationGenerator do
  before(:each) do
    @user = Factory.build(:user)
    @recommendation_generator = RandomUserRecommendationGenerator.new(@user)
  end

  describe "Recommending users" do
    it "should return likes equal to the number of likes requested" do
      7.times do
        Factory(:user)
      end
      @recommendation_generator.generate_recommendations(5).size.should == 5
    end
  end
end