require 'spec_helper'

describe UsersController do
=begin
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
=end

  describe "GET 'create'" do
    before(:each) do
      @user_params = {:profile_attributes=>{:name_attributes=>{:first=>"First_name", :last=>"Last_name"}, :age_attributes =>{"date_of_birth(1i)"=>"1900", "date_of_birth(2i)"=>"2", "date_of_birth(3i)"=>"5"}, :gender_attributes=>{:female=>"false"}}, :habitation_attributes=>{:locations_attributes=>{"0"=>{:number=>"11111", :_type=>"Zipcode"}}}, :email=> "s@s.com", :password=>"s", :password_confirmation=>"s"}
    end
=begin    
    it "should redirect to index with a notice on successful save" do
      User.any_instance.stubs(:valid?).returns(true)
      post 'create'
      assigns[@user_params[:user]].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(user_path)
    end

    it "should re-render new template on failed save" do
      User.any_instance.stubs(:valid?).returns(false)
      post 'create'
      assigns[@user_params[:user]].should be_new_record
      flash[:notice].should be_nil
      response.should render_template('new')
    end
=end    
    it "should pass first name to user" do
      @user_params[:profile_attributes][:name_attributes][:first] = "greg"
      post 'create', :user => @user_params
      assigns[:user].profile.name.first.should == 'greg'
    end
    
    it "should pass last name to user" do
      @user_params[:profile_attributes][:name_attributes][:last] = "Thompson"
      post 'create', :user => @user_params
      assigns[:user].profile.name.last.should == 'Thompson'
    end
    
    it "should pass gender to user" do
      @user_params[:profile_attributes][:gender_attributes][:female] = true
      post 'create', :user => @user_params
      assigns[:user].profile.gender.female.should == true
    end

    it "should pass age to user" do
      @user_params[:profile_attributes][:age_attributes]["date_of_birth(1i)"] = "1900"
      @user_params[:profile_attributes][:age_attributes]["date_of_birth(2i)"] = "06"
      @user_params[:profile_attributes][:age_attributes]["date_of_birth(3i)"] = "27"

      post 'create', :user => @user_params
      assigns[:user].profile.age.date_of_birth.to_s.should == Date.strptime("{1900,06,27}", "{%Y,%m, %d}").to_s
    end
    
    it "should pass zipcode type residence to user" do
      @user_params[:habitation_attributes][:locations_attributes]["0"][:_type] = "Zipcode"
      @user_params[:habitation_attributes][:locations_attributes]["0"][:number] = "11111"

      post 'create', :user => @user_params
      
      assigns[:user].habitation.locations.each do |location|
        location._type.should == "Zipcode"
        location.number.should == "11111"
      end
    end

  end
end