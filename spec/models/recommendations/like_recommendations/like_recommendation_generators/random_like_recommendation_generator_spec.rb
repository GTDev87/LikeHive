require 'spec_helper'

describe RandomLikeRecommendationGenerator do
  before(:each) do
    @user = Factory.build(:user)
    @recommendation_generator = RandomLikeRecommendationGenerator.new(@user)
  end

  describe "Recommending likes" do
    it "should return likes equal to the number of likes requested" do
      (1..20).each do
        like = Factory(:like)
      end
      num = @recommendation_generator.generate_interests(5).size
      num.should == 5
    end
    
    it "should return likes not owned by user" do
      unowned_likes = {}
      owned_likes = {}
      
      unowned_likes[Factory(:like).name] = true
      @user.add_like(Factory(:like).name)
      unowned_likes[Factory(:like).name] = true
      @user.add_like(Factory(:like).name)
      unowned_likes[Factory(:like).name] = true
      @user.add_like(Factory(:like).name)
      unowned_likes[Factory(:like).name] = true
      @user.add_like(Factory(:like).name)
      
      @recommendation_generator.generate_interests(4).each do |like|
        owned_likes.should_not have_key(like.name)
        unowned_likes.should have_key(like.name)
      end
    end
  end
end