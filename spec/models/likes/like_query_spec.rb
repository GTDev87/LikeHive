require 'spec_helper'

describe LikeQuery do
  before(:each) do
    @pizza = Factory(:like, :name => 'Pizza')
    @french_fries = Factory(:like, :name => 'French Fries')
    @sunshine = Factory(:like, :name => 'Sunshine')
  end
  describe "finding likes" do
    it "should find likes with the name mentioned by id" do      
      LikeQuery.find(@pizza.id).name.should == "pizza"
      LikeQuery.find(@french_fries.id).name.should == "french fries"
      LikeQuery.find(@sunshine.id).name.should == "sunshine"
    end
  end
  describe "finding all likes" do
    it "should return all likes when all is called" do
      likes = LikeQuery.all
      likes.should contain_result_named("pizza")
      likes.should contain_result_named("french fries")
      likes.should contain_result_named("sunshine")

      likes.size.should == 3   
    end
  end
  describe "finding one like" do
    it "should return one like if find_one is called" do
      LikeQuery.find_one_by_name("sunshine").name.should == "sunshine"
    end
    
    it "should return one like case insensitive" do
      LikeQuery.find_one_by_name("SuNsHiNe").name.should == "sunshine"
    end
    
    it "should return nil if find_one is called with unknown like" do
      LikeQuery.find_one_by_name("kickboxing") == nil
    end
  end
end