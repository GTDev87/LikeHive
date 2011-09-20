class UsersController < ApplicationController
  before_filter :authenticate_user!

  def new
    @user = UserCreator.new
  end
  
  def list
    @users = UserQuery.all()
  end

  def show
    @user = UserQuery.find(params[:id])
    authorize! :read, @user
  end
  
  def create
    puts "user birthday = #{params[:date_of_birth]}"
    @user = UserCreator.create!(params[:user])
    
  end
  
  def update
    @user = UserQuery.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
end
