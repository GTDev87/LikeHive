require 'spec_helper'

describe CriteriaQuery do
  before(:each) do
    
  end
  describe "returning likes" do
    it "should return random likes" do      
      7.times do
        like = Factory(:like)
      end
      
      query = CriteriaQuery.new(Like.all)
      query.return_n_random(5).size.should == 5
    end
    
    it "should return all distinct likes" do      
      7.times do
        like = Factory(:like)
      end
      
      query = CriteriaQuery.new(Like.all)
      likes = query.return_n_random(5)
      
      valid_hash = {}
      likes.each do |like|
        valid_hash[like.name] =true
      end
      
      valid_hash.size.should == 5
    end
  end
  
  describe "returning users" do
    it "should return random users" do      
      7.times.each do
        like = Factory(:user)
      end
      
      query = CriteriaQuery.new(User.all)
      query.return_n_random(5).size.should == 5
    end
    
    it "should return all distinct users" do      
      7.times.each do
        like = Factory(:user)
      end
      
      query = CriteriaQuery.new(User.all)
      users = query.return_n_random(5)
      
      valid_hash = {}
      users.each do |user|
        valid_hash[user.name] =true
      end
      
      valid_hash.size.should == 5
    end
  end
end