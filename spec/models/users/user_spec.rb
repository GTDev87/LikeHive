require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  it "should create a new instance given a valid attribute" do
    UserCreator.create!(@attr)
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
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
      @user = User.create!(@attr)
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
      greg = User.create(
      :name => "Greg",
      :email => "greg@example.com",
      :password => "foobar",
      :password_confirmation => "foobar")
      
      greg.like_name = "ketchup"
      greg.save!
      
      amol = User.create(
      :name => "Amol",
      :email => "amol@example.com",
      :password => "foobar",
      :password_confirmation => "foobar")
      
      amol.like_name = "ketchup"
      amol.save!      
      
      Like.count.should == 1
    end
  end
end