require 'spec_helper'

describe MessageData do
  describe "Validating Messages" do    
    it "should require non empty to" do
      message_data = Factory.build(:message_data, :to => [])
    
      message_data.should_not be_valid
    end
    
    it "should require valid to" do
      message_data = Factory.build(:message_data)
      message_data.to << nil
    
      message_data.should_not be_valid
    end
    
    it "should require valid to" do
      message_data = Factory.build(:message_data)
      message_data.to << Factory.build(:user)
    
      message_data.should be_valid
    end
  
    it "should require non empty from" do
      message_data = Factory.build(:message_data, :from => "")
    
      message_data.should_not be_valid
    end
    
    it "should require non nil from" do
      message_data = Factory.build(:message_data, :from => nil)
    
      message_data.should_not be_valid
    end
    
    it "should require non empty timestamp" do
      message_data = Factory.build(:message_data, :time => "")
    
      message_data.should_not be_valid
    end
    
    it "should require non nil timestamp" do
      message_data = Factory.build(:message_data, :time => nil)
    
      message_data.should_not be_valid
    end
    
    it "should initialize time to current time" do
      Timecop.freeze(DateTime.now) do
        message = ContactMessage.new
        message.build_message_data
        message.message_data.time.should == DateTime.now
      end
      Timecop.return()
    end

  end
  describe "adding multiple users to messages" do
    it "should have the ability to receive message from multiple users" do
      user = Factory.build(:user)
      
      message_data_1 = Factory.build(:message_data)
      message_data_1.to << user
      
      message_data_2 = Factory.build(:message_data)
      message_data_2.to << user
      
      message_data_1.to.should == [user]
      message_data_2.to.should == [user]
    end
    
    it "should be able to send messages to multiple users in different messages" do
      user_from = Factory.build(:user)
      user_to_1 = Factory.build(:user)
      user_to_2 = Factory.build(:user)
      
      message_data_1 = Factory.build(:message_data, :from => user_from)
      message_data_1.to << user_to_1
      
      message_data_2 = Factory.build(:message_data, :from => user_from)
      message_data_2.to << user_to_2
      
      message_data_1.to.should == [user_to_1]
      message_data_2.to.should == [user_to_2]
    end
    
    it "should be able to send messages to multiple users in single message" do
      user_from = Factory.build(:user)
      user_to_1 = Factory.build(:user)
      user_to_2 = Factory.build(:user)

      message_data = Factory.build(:message_data, :from => user_from)
      message_data.to << user_to_1
      message_data.to << user_to_2
      
      message_data.to.should == [user_to_1, user_to_2]
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
      message_data = Factory.build(:message_data, from: @greg, to: [@reid, @amol, @zac])
      user_container = message_data.associated_users
      user_visitor = MockUserVisitor.new()
      
      user_container.accept_user_visitor(user_visitor)
      user_visitor.users_visited.should =~ [@greg, @reid, @amol, @zac]
    end
  end
end