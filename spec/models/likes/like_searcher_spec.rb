
require 'spec_helper'

describe LikeSearcher do  
  before(:each) do
    @searcher =  LikeSearcher.new()
  end
  
  describe "searching for words in like" do
    it "should search for like" do
      @searcher.word_search("fish")
      Sunspot.session.should have_search_params(:keywords, 'fish')

    end      
    
    it "should search for multi word like" do
      @searcher.word_search("flying fish")
      Sunspot.session.should have_search_params(:keywords, 'flying fish')

    end 
    
    it "should return nothing if search is empty" do
      @searcher.word_search("").should == []      
      Sunspot.session.should_not have_search_params(:keywords, '')
    end
    
    it "should return nothing if search is blank" do
      @searcher.word_search(" ").should == []      
      Sunspot.session.should_not have_search_params(:keywords, ' ')
    end
  end
end