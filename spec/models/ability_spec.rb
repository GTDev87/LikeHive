require 'spec_helper'

require "cancan/matchers"

# ...
#ability.should be_able_to(:destroy, Project.new(:user => user))
#ability.should_not be_able_to(:destroy, Project.new)

describe Ability do  
  describe "User's Abilities" do
    before(:each) do
      @user = Factory(:user)
      @ability = Ability.new(@user)
    end
    
    it "should have ability to read own page" do
      @ability.should be_able_to(:read, @user)
    end
    
    it "should create a user when create is called" do
      @ability.should_not be_able_to(:read, Factory(:user))
    end
  end
end