require 'spec_helper'

describe UserPeek do
  before(:each) do
    @user = Factory.build(:user)
  end

  describe "returning similar likes" do
    it "should return similar likes when calculate similarities is called" do
      peek = UserPeek.new(@user)
      other_user = Factory.build(:user)
      pizza = Factory.build(:like, :name => "pizza")
      
      @user.personality.likes << pizza
      other_user.personality.likes << pizza
      
      peek.calculate_similarities(other_user)
      peek.similar_likes.should == [pizza]
    end
    
    it "should create a handshake between the two users" do
      peek = UserPeek.new(@user)
      other_user = Factory.build(:user)
      pizza = Factory.build(:like, :name => "pizza")
      
      @user.personality.likes << pizza
      other_user.personality.likes << pizza
      
      peek.calculate_similarities(other_user)
      
      peek.handshake.message_data.from.should == @user
      peek.handshake.message_data.to.should == [other_user]
    end
  end
end