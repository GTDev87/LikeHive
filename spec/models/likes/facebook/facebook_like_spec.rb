require 'spec_helper'

describe FacebookLike do
  describe "validation" do
    it "should initialize with facebook data" do
      facebook_like = Factory.build(:facebook_like)
      
      facebook_like.should be_valid
    end
  end
end
