require 'spec_helper'

describe LikeCriteriaQuery do
  before(:each) do
    
  end
  describe "finding likes" do
    it "should return random likes" do      
      7.times do
        like = Factory(:like)
      end
      
      query = LikeCriteriaQuery.new(Like.all)
      query.return_n_random(5).size.should == 5
    end
    
    it "should return all distinct likes" do      
      7.times do
        like = Factory(:like)
      end
      
      query = LikeCriteriaQuery.new(Like.all)
      likes = query.return_n_random(5)
      
      valid_hash = {}
      likes.each do |like|
        valid_hash[like.name] =true
      end
      
      valid_hash.size.should == 5
    end
  end
end