
require 'spec_helper'

describe LikeSearcher do  

  before(:each) do

    #Like.create(:name => "fish")
    #Like.create(:name => "chicken")
    #Like.create(:name => "catFish")
    #Like.create(:name => "beef")
    #Like.create(:name => "flying fish")
    #Like.create(:name => "pork")
    #Like.create(:name => "bacon")
  end
   
  describe "searching for like" do
    it "should search for like" do
      LikeSearcher.search("fish")
      Sunspot.session.should have_search_params(:keywords, 'fish')

    end      
    
    it "should search for multi word like" do
      LikeSearcher.search("flying fish")
      Sunspot.session.should have_search_params(:keywords, 'flying fish')

    end      
  end
end