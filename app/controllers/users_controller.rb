class UsersController < ApplicationController
  before_filter :authenticate_user!

  def new
    @user = User.new
  end
  
  def list
    @users = User.all()
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user.addLike(params[:user])
    redirect_to users_url, :notice => "Added Like"

  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
end
