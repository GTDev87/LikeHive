require 'spec_helper'

describe LikeQuery do
  before(:each) do
    @pizza = Factory(:like, :name => 'Pizza')
    @french_fries = Factory(:like, :name => 'French Fries')
    @sunshine = Factory(:like, :name => 'Sunshine')
  end
  describe "finding likes" do
    it "should find likes with the name mentioned by id" do      
      LikeQuery.find(@pizza.id).name.should == "Pizza"
      LikeQuery.find(@french_fries.id).name.should == "French Fries"
      LikeQuery.find(@sunshine.id).name.should == "Sunshine"
    end
  end
  describe "finding all likes" do
    it "should return all likes when all is called" do
      likes = LikeQuery.all
      likes.should contain_result_named("Pizza")
      likes.should contain_result_named("French Fries")
      likes.should contain_result_named("Sunshine")

      likes.size.should == 3   
    end
  end
  describe "finding one like" do
    it "should return one like if find_one is called" do
      LikeQuery.find_one_by_name("Sunshine").name.should == "Sunshine"
    end
    
    it "should return one like case sensitive" do
      LikeQuery.find_one_by_name("SuNsHiNe").should == nil
    end
    
    it "should return nil if find_one is called with unknown like" do
      LikeQuery.find_one_by_name("kickboxing").should == nil
    end
  end
  
  describe "finding one like" do
    before (:each) do 
      Factory(:like, :name => 'Galileo')
      Factory(:like, :name => 'Anger')
    end
    
    it "should return criteria with all except single name specified" do
      criteria = LikeQuery.query_likes_without_names(["Sunshine"])
      criteria.query_returner.return_all.should_not contain_result_named("Sunshine")
      criteria.query_returner.return_all.should contain_result_named("French Fries")
      criteria.query_returner.return_all.should contain_result_named("Galileo")
      criteria.query_returner.return_all.should contain_result_named("Anger")
      criteria.query_returner.return_all.should contain_result_named("Pizza")
    end
    
    it "should return criteria with all except multiple names specified" do
      criteria = LikeQuery.query_likes_without_names(["Sunshine", "Pizza", "Galileo"])
      criteria.query_returner.return_all.should_not contain_result_named("Sunshine")
      criteria.query_returner.return_all.should_not contain_result_named("Galileo")
      criteria.query_returner.return_all.should_not contain_result_named("Pizza")
      criteria.query_returner.return_all.should contain_result_named("French Fries")
      criteria.query_returner.return_all.should contain_result_named("Anger")
    end
    
    it "should return all if no names specified" do
      criteria = LikeQuery.query_likes_without_names([])
      criteria.query_returner.return_all.should contain_result_named("Sunshine")
      criteria.query_returner.return_all.should contain_result_named("Galileo")
      criteria.query_returner.return_all.should contain_result_named("Pizza")
      criteria.query_returner.return_all.should contain_result_named("French Fries")
      criteria.query_returner.return_all.should contain_result_named("Anger")
    end
  end
end