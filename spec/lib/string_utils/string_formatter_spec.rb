
require 'spec_helper'

describe StringFormatter do
  describe "Capitalizing words" do
    it "should capital words if capitalise_words is called" do
      StringFormatter.capitalize_words("flying Fighting fIsH").should == "Flying Fighting Fish"
    end    
  end 
  
  describe "LowerCasing words" do
    it "should lowercase words if lowercase is called" do
      StringFormatter.lowercase("flying Fighting fIsH").should == "flying fighting fish"
    end    
  end
  
  describe "Splitting words" do
    it "should split words by commas" do
      StringFormatter.split_by_commas(" red, blue , green   ,  black ").should == ["red", "blue", "green", "black"]
    end    
  end
end