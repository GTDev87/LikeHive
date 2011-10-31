require 'spec_helper'

describe UserName do  
  describe "Finding Name" do
    it "should save valid first name" do    
      user_name = Factory.build(:user_name, :first => "Greg")
      user_name.should be_valid
    end
    
    it "should require first name" do    
      user_name = Factory.build(:user_name, :first => "")
      user_name.should_not be_valid
    end
    
    it "should record first name" do    
      user_name = Factory.build(:user_name, :first => "Greg")
      user_name.first.should == "Greg"
    end
  
    it "should record last initial" do    
      user_name = Factory.build(:user_name, :last_initial => "T")
      user_name.last_initial.should == "T"
    end
  end
end