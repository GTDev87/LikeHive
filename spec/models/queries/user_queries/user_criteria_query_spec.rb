require 'spec_helper'

describe UserCriteriaQuery do
  before(:each) do
    
  end
  describe "finding users" do
    it "should return random users" do      
      7.times do
        like = Factory(:user)
      end
      
      query = UserCriteriaQuery.new(User.all)
      query.return_n_random(5).size.should == 5
    end
    
    it "should return all distinct likes" do      
      7.times do
        like = Factory(:user)
      end
      
      query = UserCriteriaQuery.new(User.all)
      users = query.return_n_random(5)
      
      valid_hash = {}
      users.each do |user|
        valid_hash[user.name] =true
      end
      
      valid_hash.size.should == 5
    end
  end
end