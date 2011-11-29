require 'spec_helper'

describe UserNetwork do
  describe "User Network" do
    it "should be valid if user is valid" do
      user = Factory.build(:user)
      invalid_user_network = Factory.build(:user_network, contacts: [user])
    
      invalid_user_network.should be_valid
    end
    
    it "should not be valid if user is not valid" do
      user = Factory.build(:user, profile: nil)
      invalid_user_network = Factory.build(:user_network, contacts: [user])
    
      invalid_user_network.should_not be_valid
    end
  end
  describe "saving new contact" do
    before(:each) do
      @greg = Factory(:user, username: "Greg")
      @amol = Factory(:user, username: "Amol")
    end
    it "should add new contact if in virtual contact field" do
      
      @amol.network.virtual_contact = "Greg"
      
      @amol.network.save!
      @amol.reload
      @greg.reload
      
      @amol.network.contacts.should == [@greg]
      @greg.network.contacts.should == [@amol]
    end
    
    it "should not have the same contact twice" do
      
      2.times do
        @amol.network.virtual_contact = "Greg"
        @amol.network.save!
        
        @amol.reload
        @greg.reload
      end
      @amol.network.contacts.should == [@greg]
      @greg.network.contacts.should == [@amol]
    end
    
    it "should hold all contacts in container" do
      reid = Factory(:user, username: "Reid")
      zac = Factory(:user, username: "Zac")
      @greg.network.contacts << reid
      @greg.network.contacts << zac
      
      found_greg = UserQuery.find_user_by_username("Greg")
      
      user_holder = []
      visitor = UserVisitor.new(user_holder)
      found_greg.network.user_connection_container.accept_user_visitor(visitor)
      
      user_holder.should =~ [reid, zac]
    end
  end
   
  describe "acceptance message" do
    before(:each) do
      @greg = Factory(:user, username: "Greg")
      @amol = Factory(:user, username: "Amol")
    end
    
    it "should send acceptance message on save" do
      @amol.network.virtual_contact = "Greg"
      
      @amol.network.save!
      @amol.reload
      @greg.reload
      
      @amol.mailbox.messages.should == @greg.mailbox.messages
      
      acceptance_message = @amol.mailbox.messages.first
      acceptance_message.message_data.to.first.should == @greg
      acceptance_message.message_data.from.should == @amol
      acceptance_message.message_data.subject.should == "[Handshake Accepted] #{@amol.username}"
    end
  end
end