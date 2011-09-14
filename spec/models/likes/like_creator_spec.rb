require 'spec_helper'

describe LikeCreator do
  describe "create like" do
    it "should create a like when new is called" do
      attr = {:name => "Greg"}
      like = LikeCreator.new(attr)
      like.name.should == "greg"
      Like.count.should == 0
    end
    
    it "should create a like when create is called" do
      attr = {:name => "Greg"}
      like = LikeCreator.create(attr)
      like.name.should == "greg"
      Like.count.should == 1
    end
  end
end