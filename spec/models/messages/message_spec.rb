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
    
    it "should initialize time to current time" do
      Timecop.freeze(DateTime.now) do
        message = Message.new
        message.time.should == DateTime.now
      end
      Timecop.return()
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
  
  describe "To username parsing" do
    before(:each) do
      @greg = Factory(:user, username: "GregT")
      @reid = Factory(:user, username: "ReidH")
      @amol = Factory(:user, username: "AmolK")
      @zac = Factory(:user, username: "ZacC")
    end
        
    it "should add existing users to to list" do
      message = Factory.build(:message)
      message.to_username_list = "GregT, ReidH, AmolK, ZacC"
      message.save!
      
      message.to.size.should == 4
    end
    
    it "should parse usernames before validation" do
      message = Factory.build(:message)
      message.to_username_list = "GregT, ReidH, AmolK, ZacC"

      message.should be_valid
    end
    
    it "should parse usernames before save" do
      message = Factory.build(:message)
      message.to_username_list = "GregT, ReidH, AmolK, ZacC"
      message.save!
      
      message.should be_valid
    end
        
    it "should not be valid if list is empty" do
      message = Factory.build(:message)
      message.to_username_list = ""
      
      message.should_not be_valid
    end
    
    it "should not be valid if does not recognize any user" do
      message = Factory.build(:message)
      message.to_username_list = "A, B, C, D"
      
      message.should_not be_valid
      message.to.size.should == 0
    end
  end
  describe "users receiving messages" do
    before(:each) do
      @greg = Factory(:user, username: "GregT")
      @reid = Factory(:user, username: "ReidH")
      @amol = Factory(:user, username: "AmolK")
      @zac = Factory(:user, username: "ZacC")
    end
    
    it "should give message to a user it is sent to after save" do
      message = Factory.build(:message)
      message.body = "sent message"
      message.to_username_list = "GregT"
      message.save!
      
      @greg.reload
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.body.should == "sent message"
    end
    
    it "should give message to multiple user it is sent to after save" do
      message = Factory.build(:message)
      message.body = "sent message"
      message.to_username_list = "GregT, ReidH, AmolK, ZacC"
      message.save!
      
      @greg.reload
      @reid.reload
      @amol.reload
      @zac.reload
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.body.should == "sent message"
      
      @reid.mailbox.messages.size.should == 1
      @reid.mailbox.messages.first.body.should == "sent message"
      
      @amol.mailbox.messages.size.should == 1
      @amol.mailbox.messages.first.body.should == "sent message"
      
      @zac.mailbox.messages.size.should == 1
      @zac.mailbox.messages.first.body.should == "sent message"
    end
    
    it "should give message to a user it is sent from after save" do
      message = Factory.build(:message)
      message.body = "sent message"
      message.from = @greg
      message.to_username_list = "AmolK"
      message.save!
      
      @greg.mailbox.messages.size.should == 1
      @greg.mailbox.messages.first.body.should == "sent message"
    end
    
    it "should be able to give multiple messages to users" do
      message = Factory.build(:message)
      message.body = "sent message 1"
      message.to_username_list = "GregT"
      message.save!
      
      message2 = Factory.build(:message)
      message2.body = "sent message 2"
      message2.to_username_list = "GregT"
      message2.save!
      
      @greg.reload
      
      @greg.mailbox.messages.size.should == 2
      @greg.mailbox.messages.first.body.should == "sent message 1"
      @greg.mailbox.messages.last.body.should == "sent message 2"
    end
  end
  
  describe "Associated Users" do
    class MockUserVisitor
      attr_reader :users_visited
      def initialize()
        @users_visited = []
      end
      def visit_user(user)
        @users_visited << user
      end
    end
    
    it "should return all users in from and to list of message" do
      @greg = Factory(:user, email: "greg@test.com")
      @reid = Factory(:user, email: "reid@test.com")
      @amol = Factory(:user, email: "amol@test.com")
      @zac = Factory(:user, email: "zac@test.com")
      message = Factory.build(:message, from: @greg, to: [@reid, @amol, @zac])
      user_container = message.associated_users
      user_visitor = MockUserVisitor.new()
      
      user_container.accept_user_visitor(user_visitor)
      user_visitor.users_visited.should =~ [@greg, @reid, @amol, @zac]
    end
  end
end