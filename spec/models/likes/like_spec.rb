require 'spec_helper'

describe Like do
  
  before(:each) do    
    @user = Factory(:user)
  end
  
  describe "name" do
    it "should create a like using a lowercase name" do
      pizza = Factory(:like, :name => "pIzZa")
      pizza.name.should == "pizza"
    end
  
    it "should create a like using a lowercased name with multiple words" do
      pizza = Factory(:like, :name => "PEPPERONNI pizza")
      pizza.name.should == "pepperonni pizza"
    end
  end
  
  describe "num users" do
    it "should initialize number of likes to 0" do
      pizza = Factory(:like, :name => "pizza")
      pizza.num_users.should == 0
    end
    
    it "should show number of users" do
      pizza = Factory(:like, :name => "pizza")
      pizza.get_followers << @user
      pizza.num_users.should == 1
    end
    
    it "should not update number of users if save is not called" do
      pizza = Factory(:like, :name => "pizza")
      pizza.users << @user
      pizza.num_users.should == 0
    end
  end
end
