require 'spec_helper'

describe UserLikeLocatorVisitor do  
  describe "locating user" do
    it "should find like with same name" do
      pizza = Factory.build(:like, :name => "pizza")
      user_like_visitor = UserLikeLocatorVisitor.new("pizza")
      user_like_visitor.continue_visit_like(pizza).should be_false
      user_like_visitor.found_like.should be(pizza)
    end
    
    it "should return nil when like is not found" do      
      pizza = Factory.build(:like, :name => "pizza")
      user_like_visitor = UserLikeLocatorVisitor.new("cookies")
      user_like_visitor.continue_visit_like(pizza).should be_true
      user_like_visitor.found_like.should be_nil
    end    
  end
end