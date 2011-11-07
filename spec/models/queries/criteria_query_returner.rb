require 'spec_helper'

describe CriteriaQueryReturner do
  before(:each) do
    
  end
  describe "returning likes" do
    it "should return random likes" do      
      7.times do
        like = Factory(:like)
      end
      
      query_returner = CriteriaQueryReturner.new(CriteriaQuery.new(Like.all))
      query_returner.return_n_random(5).size.should == 5
    end
    
    it "should return all distinct likes" do      
      7.times do
        like = Factory(:like)
      end
      
      query_returner = CriteriaQueryReturner.new(CriteriaQuery.new(Like.all))
      likes = query_returner.return_n_random(5)
      
      valid_hash = {}
      likes.each do |like|
        valid_hash[like.name] =true
      end
      
      valid_hash.size.should == 5
    end
  end
end