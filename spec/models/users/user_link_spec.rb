require 'spec_helper'

describe UserLink do
  before(:each) do
    @user = Factory.build(:user)
  end

  describe "returning similar likes" do
    before(:each) do
      @other_user = Factory.build(:user)
      @pizza = Factory.build(:like, :name => "pizza")
      
      @user.personality.likes << @pizza
      @other_user.personality.likes << @pizza
    end
    
    it "should return similar likes when calculate similarities is called" do
      link = UserLink.new(@user)
      link.create_link_interface(@other_user)
      
      link.similar_likes.should == [@pizza]
      link.other_user.should == @other_user
    end
    
    it "should create handshake between users" do
      link = UserLink.new(@user)
      link.create_link_interface(@other_user)
      
      link.handshake.message_data.from.should == @user
      link.handshake.message_data.to.should == [@other_user]
      link.handshake.message_data.subject.should == "[Handshake Extended] #{@user.username}"
    end
  end
end