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
    invalid_first_name = Factory.build(:user, :first_name => "")
    invalid_first_name.should_not be_valid
  end
  
  it "should record last initial" do    
    user = Factory.build(:user, :last_initial => "T")
    user.last_initial.should == "T"
  end
  
  it "should record gender" do    
    user = Factory.build(:user, :female => true)
    user.female.should be_true
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
    
    it "should reject short passwords" do
      short = "a" * 5
      Factory.build(:user, :password => short, :password_confirmation => short)
        .should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
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
      @user.save
      @user.like_name = "BreadSticks"
      @user.save
      
      @user.get_likes.find_like("pizza").should be_true
      @user.get_likes.find_like("breadsticks").should be_true
      @user.get_likes.find_like("running").should be_false
    end
    
    it "should add multiple likes data after save" do
      @user.like_box = "Pizza, BreadSticks"
      @user.save
      
      @user.get_likes.find_like("pizza").should be_true
      @user.get_likes.find_like("breadsticks").should be_true
      @user.get_likes.num_likes.should == 2
      
    end
  end  
  
  describe "between multiple users" do    
    
    it "should keep likes referenced between multiple users" do 
      greg = Factory(:user, :first_name => "Greg")
      
      greg.like_name = "ketchup"
      greg.save!
      
      amol = Factory(:user, :first_name => "Amol")
      
      amol.like_name = "ketchup"
      amol.save!      
      
      Like.count.should == 1
    end
  end
end