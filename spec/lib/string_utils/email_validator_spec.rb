require 'spec_helper'

def validate_each(object, attribute, value)
    unless value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
      object.errors[attribute] << (options[:message] || "is not formatted properly") 
    end
  end

describe EmailValidator do  
  
  before (:each) do
    @validator = EmailValidator.new({:attributes => {} })
    @mock_model = mock('model')
    @mock_model.stub("errors").and_return([])
    @mock_model.errors.stub('[]').and_return({})
    @mock_model.errors[].stub('<<')
  end
  
  describe "Validating email string" do
    before(:each) do
      
    end
    it "should make sure emails are not blank" do
      @mock_model.should_receive('errors')
      @validator.validate_each(@mock_model, "email", "")
    end
    
    it "should make sure emails do not have black spaces" do 
      @mock_model.should_receive('errors')
      @validator.validate_each(@mock_model, "email", "test@ test.com")
    end
    
    it "should validate valid email has @" do
      @mock_model.should_receive('errors')
      @validator.validate_each(@mock_model, "email", "testtest.com")
    end
    
    it "should validate valid email has ." do
      @mock_model.should_receive('errors')
      @validator.validate_each(@mock_model, "email", "test@testcom")
    end
    
    it "should validate valid email" do
      @mock_model.should_not_receive('errors')
      @validator.validate_each(@mock_model, "email", "test@test.com")
    end
  end
end