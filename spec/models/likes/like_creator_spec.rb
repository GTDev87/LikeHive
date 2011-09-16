require 'spec_helper'

describe LikeCreator do
  describe "create like" do
    it "should create a like when new is called" do
      attr = {:name => "Pizza"}
      like = LikeCreator.new(attr)
      like.name.should == "pizza"
      Like.count.should == 0
    end
    
    it "should create a like when create is called" do
      attr = {:name => "pizza"}
      like = LikeCreator.create(attr)
      like.name.should == "pizza"
      Like.count.should == 1
    end
  end
end