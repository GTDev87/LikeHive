require 'spec_helper'

describe Zipcode do  
  describe "Validating Zipcode" do
    it "should require non empty zipcode" do
      zipcode = Factory.build(:zipcode, :number => "")
    
      zipcode.should_not be_valid
    end
    
    it "should require non nil zipcode" do
      zipcode = Factory.build(:zipcode, :number => nil)
    
      zipcode.should_not be_valid
    end
  
    it "should require valid zipcode" do    
      zipcode = Factory.build(:zipcode, :number => "123456")
      
      zipcode.should_not be_valid
    end
  
    it "should 5 digit zipcode valid" do    
      zipcode = Factory.build(:zipcode, :number => "12345")
      
      zipcode.should be_valid
    end
  
    it "should 9 digit zipcode valid" do
      zipcode = Factory.build(:zipcode, :number => "123456789")
      
      zipcode.should be_valid
    end
  
    it "should 9 digit zipcode with dash valid" do    
      zipcode = Factory.build(:zipcode, :number => "12345-6789")
      
      zipcode.should be_valid
    end
  end
end