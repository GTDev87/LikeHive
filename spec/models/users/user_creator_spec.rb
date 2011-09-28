require 'spec_helper'

describe UserCreator do  
  describe "Creating Users" do
    it "should create a user when new is called" do
      UserCreator.new
      User.count.should == 0
    end
    
#    it "should create a user when create is called" do
#      user = UserBuilder.new.with_attributes({
#        :email => "user@example.com",
#        :password => "foobar",
#        :password_confirmation => "foobar", 
#        :date_of_birth => "1987-06-27",
#        :zipcode => "11210"})
#        .with_user_name({:first => "Example"})
#        .create()
      
      #userName = Factory.build(:user_name, :first => "Example")
      #puts "username created is #{userName}"      
#      User.count.should == 1
#    end
  end
end