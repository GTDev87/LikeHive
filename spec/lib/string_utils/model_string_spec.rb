=begin
require 'spec_helper'

describe ModelString do
  describe "object initialization and validity" do
    it "should initialize with lowercase words" do
      my_like = ModelString.new(" MyLiKe IsHeRe ")
      my_like.string.should == "mylike ishere"
    end
    
    it "should be valid with characters" do
      my_like = ModelString.new(" a ")
      my_like.is_valid == true
    end
    
    it "should not say blank like is valid" do
      my_like = ModelString.new("  ")
      my_like.is_valid == false
    end
    
    it "should not say nil like is valid" do
      my_like = ModelString.new(nil)
      my_like.is_valid == false
    end
  end
end
=end