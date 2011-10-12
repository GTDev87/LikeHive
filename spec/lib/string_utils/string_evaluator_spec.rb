require 'spec_helper'

describe StringEvaluator do
  describe "Finding if word is blank" do
    it "should recognize empty words" do
      StringEvaluator.string_is_blank("").should be_true
    end
    
    it "should recognize blank words" do
      StringEvaluator.string_is_blank(" ").should be_true
    end
    
    it "should recognize not empty" do
      StringEvaluator.string_is_blank(" hello ").should_not be_true
    end
  end
end