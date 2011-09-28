require 'spec_helper'

describe User do 
  it "should create a new instance given a valid attribute" do
    Factory(:user)
  end
  
  it "should require an email address" do
    no_email_user = Factory.build(:user, :email => "")
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = no_email_user = Factory.build(:user, :email => address)
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = Factory.build(:user, :email => address)
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should require first name" do    
    invalid_first_name = Factory.build(:user, :name => Factory.build(:user_name, :first => ""))
    invalid_first_name.should_not be_valid
  end
  
  it "should record last initial" do    
    user = Factory.build(:user, :name => Factory.build(:user_name, :last_initial => "T"))
    user.name.last_initial.should == "T"
  end
  
  it "should record gender" do    
    user = Factory.build(:user, :female => true)
    user.female.should be_true
  end
  
  it "should require birthday" do    
    user_invalid_birthday = Factory.build(:user, :age => Factory.build(:user_age, :date_of_birth => ""))
    user_invalid_birthday.should_not be_valid
  end
  
  it "should require zipcode" do    
    user_invalid_zipcode = Factory.build(:user, :zipcode => "")
    user_invalid_zipcode.should_not be_valid
  end
  
  it "should require valid zipcode" do    
    user_invalid_zipcode = Factory.build(:user, :zipcode => "123456")
    user_invalid_zipcode.should_not be_valid
  end
  
  it "should 5 digit zipcode valid" do    
    user_invalid_zipcode = Factory.build(:user, :zipcode => "123456789")
    user_invalid_zipcode.should be_valid
  end
  
  it "should 9 digit zipcode valid" do    
    user_invalid_zipcode = Factory.build(:user, :zipcode => "123456789")
    user_invalid_zipcode.should be_valid
  end
  
  it "should 9 digit zipcode with dash valid" do    
    user_invalid_zipcode = Factory.build(:user, :zipcode => "12345-6789")
    user_invalid_zipcode.should be_valid
  end
  
  
  it "should reject duplicate email addresses" do
    Factory(:user, :email => "duplicate@email.com")
    user_with_duplicate_email = Factory.build(:user, :email => "duplicate@email.com")
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    email = "caseinsensitive@email.com"
    upcased_email = email.upcase
    Factory(:user, :email => upcased_email)
    user_with_duplicate_email = Factory.build(:user, :email => email)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do

    before(:each) do
      @user = Factory.build(:user)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do

    it "should be valid if matching" do
      Factory.build(:user, :password => "validpass", :password_confirmation => "validpass")
        .should be_valid
    end

    it "should require a password" do
      Factory.build(:user, :password => "", :password_confirmation => "")
        .should_not be_valid
    end

    it "should require a matching password confirmation" do
      Factory.build(:user, :password_confirmation => "invalid")
        .should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:crypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.crypted_password.should_not be_blank
    end

  end      

  describe "Finding Like Data" do
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should have no likes on creation" do
      @user.num_likes == 0
    end
       
    it "should add like data after save" do
      @user.like_name = "Pizza"
      
      @user.save!
      @user.like_name = "BreadSticks"
      @user.save!
      
      @user.get_likes.find_like("pizza").should be_true
      @user.get_likes.find_like("breadsticks").should be_true
      @user.get_likes.find_like("running").should be_false
    end
    
    it "should add multiple likes data after save" do
      @user.like_box = "Pizza, BreadSticks"
      @user.save!
      
      @user.get_likes.find_like("pizza").should be_true
      @user.get_likes.find_like("breadsticks").should be_true
      @user.get_likes.num_likes.should == 2
      
    end
  end  
  
  describe "between multiple users" do    
    
    it "should keep likes referenced between multiple users" do 
      user1 = Factory(:user)
      
      user1.like_name = "ketchup"
      user1.save!
      
      user2 = Factory(:user)
      
      user2.like_name = "ketchup"
      user2.save!      
      
      Like.count.should == 1
    end
  end
end