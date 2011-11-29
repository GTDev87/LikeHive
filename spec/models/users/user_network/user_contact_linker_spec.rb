require 'spec_helper'

describe UserContactLinker do
  describe "Linking Users to Contacts" do
    before(:each) do
      @greg = Factory(:user, username: "Greg")
      @amol = Factory(:user, username: "Amol")
    end
    it "should like users to contacts" do
      
      UserContactLinker.link_contacts(@greg, @amol)
      
      @amol.reload
      @greg.reload
      
      @amol.network.contacts.should == [@greg]
      @greg.network.contacts.should == [@amol]
    end
  end
end