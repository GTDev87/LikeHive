require 'spec_helper'

describe UserQuery do
  before(:each) do
    @greg = Factory(:user, :profile => Factory.build(:user_profile, :name => Factory.build(:user_name, :first => "Greg")), :email => "Greg@greg.com")
    @zac = Factory(:user, :profile => Factory.build(:user_profile, :name => Factory.build(:user_name, :first => "Zac")), :email => "Zac@Zac.com")
    @amol = Factory(:user, :profile => Factory.build(:user_profile, :name => Factory.build(:user_name, :first => "Amol")), :email => "amol@amol.com")
  end
  
  describe "finding users" do
    it "should find users with the name mentioned by id" do      
      UserQuery.find(@zac.id).profile.name.first.should == "Zac"
      UserQuery.find(@amol.id).profile.name.first.should == "Amol"
      UserQuery.find(@greg.id).profile.name.first.should == "Greg"
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
    
    it "should return all users when all is called" do
      users_query = UserQuery.query_users_without_email(["zac@zac.com"])
      users_query.query_returner.return_all.should_not contain_result_with_first_name("Zac")
      users_query.query_returner.return_all.should contain_result_with_first_name("Amol")
      users_query.query_returner.return_all.should contain_result_with_first_name("Greg")

      users_query.query_returner.return_all.size.should == 2  
    end
  end
  
  describe "finding users by email" do
    it "should should return user object" do
      UserQuery.find_user_by_email("greg@greg.com").should == @greg
    end
    
    it "should find the user email case insensitive" do
      UserQuery.find_user_by_email("AMOL@AMOL.com").should == @amol
      UserQuery.find_user_by_email("zAc@ZaC.com").should == @zac 
    end
  end
end