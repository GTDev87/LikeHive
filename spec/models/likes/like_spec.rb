require 'spec_helper'

describe Like do
  describe "validation" do
    it "should require a following" do
      like = Factory.build(:like, :following => nil)
      like.should_not be_valid
    end
  end
  
  describe "name" do
    it "should create a like using a lowercase name" do
      pizza = Factory.build(:like, :name => "pIzZa")
      pizza.name.should == "pizza"
    end
  
    it "should create a like using a lowercased name with multiple words" do
      pizza = Factory.build(:like, :name => "PEPPERONNI pizza")
      pizza.name.should == "pepperonni pizza"
    end
    
    it "should have a unique name" do
      Factory(:like, :name => "pizza")
      pizza = Factory.build(:like, :name => "pizza")

      pizza.should_not be_valid
    end
  end
end
