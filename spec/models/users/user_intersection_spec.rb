require 'spec_helper'

describe UserIntersection do  
  describe "User similar data" do
    before(:each) do
      @user1 = Factory.build(:user)
      @user2 = Factory.build(:user)
      @user_intersection = UserIntersection.new(@user1, @user2)
    end
    it "should find all similar likes" do
      like1 = Factory.build(:like)
      like2 = Factory.build(:like)
      like3 = Factory.build(:like)
      like4 = Factory.build(:like)
      like5 = Factory.build(:like)

      @user1.personality.likes.concat([like1, like2, like5])
      @user2.personality.likes.concat([like2, like3, like4, like5]) 
      @user_intersection.similar_interests.should =~ [like2, like5]
    end
  end
end