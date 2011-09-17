require 'spec_helper'

describe UserQuery do
  before(:each) do
    @greg = Factory(:user, :first_name => "Greg", :email => "Greg@greg.com")
    @zac = Factory(:user, :first_name => "Zac", :email => "Zac@Zac.com")
    @amol = Factory(:user, :first_name => "Amol", :email => "amol@amol.com")
  end
  describe "finding users" do
    it "should find users with the name mentioned by id" do      
      UserQuery.find(@zac.id).first_name.should == "Zac"
      UserQuery.find(@amol.id).first_name.should == "Amol"
      UserQuery.find(@greg.id).first_name.should == "Greg"
    end
  end
  describe "finding all users" do
    it "should return all users when all is called" do
      users = UserQuery.all
      users.should contain_result_with_first_name("Zac")
      users.should contain_result_with_first_name("Amol")
      users.should contain_result_with_first_name("Greg")

      users.size.should == 3   
    end
  end
  
  describe "finding users by email" do
    it "should should return user object" do
      UserQuery.find_user_by_email("greg@greg.com").should == @greg
    end
    
    it "should find the user user case insensitive" do
      UserQuery.find_user_by_email("AMOL@AMOL.com").should == @amol
      UserQuery.find_user_by_email("zAc@ZaC.com").should == @zac 
    end
  end
end