require 'spec_helper'

describe UserLikeNameVisitor do  
  describe "user name visited" do
    it "should find name in vector" do      
      pizza = Factory.build(:like, :name => "pizza")
      cookies = Factory.build(:like, :name => "cookies")

      user_like_visitor = UserLikeNameVisitor.new()
      user_like_visitor.continue_visit_like(pizza)
      user_like_visitor.continue_visit_like(cookies)

      user_like_visitor.name_list.should =~ ["pizza", "cookies"]
    end
  end
end