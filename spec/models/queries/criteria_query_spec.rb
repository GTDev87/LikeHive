require 'spec_helper'

describe CriteriaQuery do
  describe "containing criteria" do
    it "hold criteria" do      
      7.times do
        like = Factory(:like)
      end
      
      query = CriteriaQuery.new(Like.all)
      query.criteria.all.size.should == 7
    end
  end
end