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
  
  describe "create multiple new likes" do
    it "should create multiple likes when generate is called" do
      likes = @user_generator.generate_multiple_likes("swimming, fishing, dogs, cats")
      
      likes.should contain_result_named("swimming")
      likes.should contain_result_named("fishing")
      likes.should contain_result_named("dogs")
      likes.should contain_result_named("cats")      
      likes.size.should == 4
      Like.count.should == 4
    end
    
    it "should not create multiple new likes if already exists and return them" do
      Factory(:like, :name => "swimming")
      Factory(:like, :name => "fishing")
      Factory(:like, :name => "dogs")
      Factory(:like, :name => "cats")

      @user_generator.generate_multiple_likes("swimming, fishing, dogs, cats").size.should == 4
      Like.count.should == 4
    end
    
    it "should not create multiple likes if user already has them" do
      @user_personality.likes << Factory.build(:like, :name => "swimming")
      @user_personality.likes << Factory.build(:like, :name => "fishing")
      likes = @user_generator.generate_multiple_likes("swimming, fishing, dogs, cats")

      likes.size.should == 2
      likes.should contain_result_named("dogs")
      likes.should contain_result_named("cats") 
    end

    it "should not create multiple likes if have empty name" do
      @user_generator.generate_multiple_likes("").size == 0
    end

    it "should not create multiple likes if have empty name" do      
      @user_generator.generate_multiple_likes(nil).size == 0
    end
  end
end