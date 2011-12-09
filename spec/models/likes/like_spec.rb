require 'spec_helper'

describe Like do
  describe "validation" do
    it "should require a following" do
      like = Factory.build(:like, :following => nil)
      like.should_not be_valid
    end
  end
  
  describe "name" do
    it "should not change case of like" do
      pizza = Factory.build(:like, :name => "pIzZa")
      pizza.name.should == "pIzZa"
    end
  
    it "should not change case of like name with multiple words" do
      pizza = Factory.build(:like, :name => "PEPPERONNI pizza")
      pizza.name.should == "PEPPERONNI pizza"
    end
    
    it "should have a unique name" do
      Factory(:like, :name => "pizza")
      pizza = Factory.build(:like, :name => "pizza")

      pizza.should_not be_valid
    end
  end
end
