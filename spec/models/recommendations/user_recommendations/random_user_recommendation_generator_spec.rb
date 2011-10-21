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
      @recommendation_generator.generate_recommendations(5).user_list.size.should == 5
    end
    
    it "should return fewer users if there are not available" do
      2.times do
        Factory(:user)
      end
      @recommendation_generator.generate_recommendations(100).user_list.size.should == 2
    end
    
    it "should not recomend self" do
      other_users = {}
      
      other_users[Factory(:user).profile.name.first] = true
      other_users[Factory(:user).profile.name.first] = true
      other_users[Factory(:user).profile.name.first] = true
      
      recommendations = @recommendation_generator.generate_recommendations(4).user_list
      recommendations.each do |user|
        other_users.should have_key(user.profile.name.first)
        user.profile.name.first.should_not be(@user.profile.name.first)
      end
    end
  end
end