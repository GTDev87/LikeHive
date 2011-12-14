require 'spec_helper'

describe UserLikeGenerator do
  before(:each) do
    @user_personality = Factory.build(:user_personality)
    @user_generator = UserLikeGenerator.new(@user_personality)
  end
  describe "adding new like" do
    it "should create a like when generate is called" do      
      @user_generator.generate_like("Swimming").name.should == "Swimming"
      Like.count.should == 1
    end
     
    it "should not create new like if already exists and return it" do
      Like.count.should == 0
      Factory(:like, :name => "Swimming")
      
      @user_generator.generate_like("Swimming").name.should == "Swimming"
      Like.count.should == 1
    end
    
    it "should not create like if usear has it already" do
      @user_personality.likes << Factory.build(:like, :name => "Swimming")
      
      @user_generator.generate_like("Swimming").should == nil
    end
    
    it "should not create like if it has empty name" do
      @user_generator.generate_like("").should == nil
    end
    
    it "should not create like if it has nil name" do
      @user_generator.generate_like(nil).should == nil
    end
    
    it "should not ignore capitalization" do
      @user_generator.generate_like("CaPiTaLiZaTiOn?").name.should == "CaPiTaLiZaTiOn?"
    end    
    
    it "should not add blank likes" do
       @user_generator.generate_like("    ").should == nil
    end
  end
end