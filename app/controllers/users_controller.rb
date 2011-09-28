class UsersController < ApplicationController
  def new
    @user = UserCreator.new
    @user.build_name
    @user.build_age
  end
  
  def list
    @users = UserQuery.all()
  end

  def show
    @user = UserQuery.find(params[:id])
    authorize! :read, @user
  end
  
  def create
    @user = User.new params[:user]
    if @user.save
      login(params[:user][:email], params[:user][:password])
      redirect_to root_url, :notice => "Welcome! You have signed up successfully."
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = UserQuery.find(params[:id])
    if @user.update_attributes(params[:user]) && @user.name.update_attributes(params[:user_name]) && @user.age.update_attributes(params[:user_age])
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
end
