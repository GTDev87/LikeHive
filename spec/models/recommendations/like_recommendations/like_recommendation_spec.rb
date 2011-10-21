require 'spec_helper'

describe LikeRecommendation do  
  describe "returning recommendations" do
    before(:each) do
      @like_list = [Factory.build(:like, name: "Pizza"), Factory.build(:like, name: "Cookies")]
      @recommendation = LikeRecommendation.new(@like_list)      
    end
    it "should return right number of likes through reader" do
      @recommendation.like_list =~ @like_list
    end
  end
end