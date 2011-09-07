require 'spec_helper'

describe LikesController do

  before (:each) do
    @like = Factory(:like)
    
  end

  describe "GET 'show'" do
    
    it "should be successful" do
      get :show, :id => @like.id
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @like.id
      assigns(:like).should == @like
    end
    
  end

end
