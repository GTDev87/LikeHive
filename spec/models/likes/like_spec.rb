require 'spec_helper'

describe Like do
  
  before(:each) do
    @attr = { 
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  describe "name" do
    it "should create a like using a lowercase name" do
      pizza = Like.create!(:name => "pIzZa")
      pizza.name.should == "pizza"
    end
  
    it "should create a like using a lowercased name with multiple words" do
      pizza = Like.create!(:name => "PEPPERONNI pizza")
      pizza.name.should == "pepperonni pizza"
    end
  end
end
