require 'spec_helper'

describe Message do  
  describe "Validating Messages" do    
    it "should require non empty to" do
      message = Factory.build(:message, :to => [])
    
      message.should_not be_valid
    end
    
    it "should require valid to" do
      message = Factory.build(:message)
      message.to << nil
    
      message.should_not be_valid
    end
    
    it "should require valid to" do
      message = Factory.build(:message)
      message.to << Factory.build(:user)
    
      message.should be_valid
    end
  
    it "should require non empty from" do
      message = Factory.build(:message, :from => "")
    
      message.should_not be_valid
    end
    
    it "should require non nil from" do
      message = Factory.build(:message, :from => nil)
    
      message.should_not be_valid
    end
    
    it "should require non empty timestamp" do
      message = Factory.build(:message, :time => "")
    
      message.should_not be_valid
    end
    
    it "should require non nil timestamp" do
      message = Factory.build(:message, :time => nil)
    
      message.should_not be_valid
    end
  end
  describe "adding multiple users to messages" do
    it "should have the ability to receive message from multiple users" do
      user = Factory.build(:user)
      
      message1 = Factory.build(:message)
      message1.to << user
      
      message2 = Factory.build(:message)
      message2.to << user
      
      message1.to.should == [user]
      message2.to.should == [user]
    end
    
    it "should be able to send messages to multiple users in different messages" do
      user_from = Factory.build(:user)
      user_to_1 = Factory.build(:user)
      user_to_2 = Factory.build(:user)
      
      message1 = Factory.build(:message, :from => user_from)
      message1.to << user_to_1
      
      message2 = Factory.build(:message, :from => user_from)
      message2.to << user_to_2
      
      message1.to.should == [user_to_1]
      message2.to.should == [user_to_2]
    end
    
    it "should be able to send messages to multiple users in single message" do
      user_from = Factory.build(:user)
      user_to_1 = Factory.build(:user)
      user_to_2 = Factory.build(:user)

      message = Factory.build(:message, :from => user_from)
      message.to << user_to_1
      message.to << user_to_2
      
      message.to.should == [user_to_1, user_to_2]
    end
  end
  
  describe "To email parsing" do
    before(:each) do
      @greg = Factory(:user, email: "greg@test.com")
      @reid = Factory(:user, email: "reid@test.com")
      @amol = Factory(:user, email: "amol@test.com")
      @zac = Factory(:user, email: "zac@test.com")
    end
        
    it "should add existing users to to list" do
      message = Factory.build(:message)
      message.to_email_list = "greg@test.com, reid@test.com, amol@test.com, zac@test.com"
      message.save!
      message.save!
      
      message.to.size.should == 4
    end
    
    it "should parse emails before validation" do
      message = Factory.build(:message)
      message.to_email_list = "greg@test.com, reid@test.com, amol@test.com, zac@test.com"

      message.should be_valid
    end
    
    it "should parse emails before save" do
      message = Factory.build(:message)
      message.to_email_list = "greg@test.com, reid@test.com, amol@test.com, zac@test.com"
      message.save!
      
      message.should be_valid
    end
        
    it "should not be valid if list is empty" do
      message = Factory.build(:message)
      message.to_email_list = ""
      
      message.should_not be_valid
    end
    
    it "should not be valid if does not recognize any user" do
      message = Factory.build(:message)
      message.to_email_list = "a@Test.com, b@test.com, c@test.com, d@test.com"
      
      message.should_not be_valid
      message.to.size.should == 0
    end
  end
end