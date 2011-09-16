require 'spec_helper'

describe UserQuery do
  before(:each) do
    @greg = Factory(:user, :name => "Greg")
    @zac = Factory(:user, :name => "Zac")
    @amol = Factory(:user, :name => "Amol")
  end
  describe "finding users" do
    it "should find users with the name mentioned by id" do      
      UserQuery.find(@zac.id).name.should == "Zac"
      UserQuery.find(@amol.id).name.should == "Amol"
      UserQuery.find(@greg.id).name.should == "Greg"
    end
  end
  describe "finding all users" do
    it "should return all users when all is called" do
      users = UserQuery.all
      users.should contain_result_named("Zac")
      users.should contain_result_named("Amol")
      users.should contain_result_named("Greg")

      users.size.should == 3   
    end
  end
  describe "finding one user" do
    it "should return one user if find_one is called" do
      UserQuery.find_one_by_name("Zac").name.should == "Zac"
    end
    
    it "should return nil if find_one is called with unknown user" do
      UserQuery.find_one_by_name("John") == nil
    end
  end
end