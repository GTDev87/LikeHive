
require 'spec_helper'

describe LikeSearcher do  
  before(:each) do
    @searcher =  LikeSearcher.new()
  end
  
  describe "searching for like" do
    it "should search for like" do
      @searcher.search("fish")
      Sunspot.session.should have_search_params(:keywords, 'fish')

    end      
    
    it "should search for multi word like" do
      @searcher.search("flying fish")
      Sunspot.session.should have_search_params(:keywords, 'flying fish')

    end 
    
    it "should return nothing if search is empty" do
      @searcher.search("").should == []      
      Sunspot.session.should_not have_search_params(:keywords, '')
    end
    
    it "should return nothing if search is blank" do
      @searcher.search(" ").should == []      
      Sunspot.session.should_not have_search_params(:keywords, ' ')
    end
  end
end