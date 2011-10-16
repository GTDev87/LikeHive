require 'spec_helper'

describe User do 
  it "should create a new instance given a valid attribute" do
    Factory(:user)
  end
  
  it "should be valid when proper arguments are passed" do
    user = Factory.build(:user)
    user.should be_valid
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
  
  it "should require vaild profile" do
    user_nil_profile = Factory.build(:user, :profile => Factory.build(:user_profile, :name => nil))
    
    user_nil_profile.should_not be_valid
  end
  
  it "should require non nil profile" do
    user_nil_profile = Factory.build(:user, :profile => nil)
    
    user_nil_profile.should_not be_valid
  end
  
  it "should require valid residence" do
    habitation = Factory.build(:user_habitation, :locations => [Factory.build(:zipcode, :number => "")])
    user_invalid_habitation = Factory.build(:user, :habitation => habitation)
    
    user_invalid_habitation.should_not be_valid
  end
  
  it "should require non nil residence" do
      user_invalid_habitation = Factory.build(:user, :habitation => nil)
    
      user_invalid_habitation.should_not be_valid
    end
  
  it "should require non nil personality" do
    user_invalid_personality = Factory.build(:user, :personality => nil)
    
    user_invalid_personality.should_not be_valid
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
      @user.personality.likes.size == 0
    end
    
    it "should add like data after save" do
      @user.like_name = "Pizza"
      @user.save!

      @user.like_name = "BreadSticks"
      @user.save!
      
      @user.personality.find_like("pizza").should be_true
      @user.personality.find_like("breadsticks").should be_true
      @user.personality.find_like("running").should be_false
    end        
    
    it "should clear like_name after save" do
      @user.like_name = "Pizza"
      @user.save!
      
      @user.like_name.should be_nil
    end
    
    it "should clear like_box after save" do
      @user.like_box = "Pizza, French Fries"
      @user.save!
      
      @user.like_box.should be_nil
    end
    
    it "should add multiple likes data after save" do
      @user.like_box = "Pizza, BreadSticks"
      @user.save!
      
      @user.personality.find_like("pizza").should be_true
      @user.personality.find_like("breadsticks").should be_true
      @user.personality.likes.size.should == 2
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