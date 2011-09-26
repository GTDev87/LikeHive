require 'spec_helper'

=begin Need to rethink this test previously came from devise
describe UsersController do

  before (:each) do
    @user = Factory(:user)
    login(@user.email, @user.password)
  end

  describe "GET 'show'" do
    
    it "should be successful" do
      
      get :show, :id => @user.id
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end    
  end
end

=end