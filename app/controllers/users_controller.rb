class UsersController < ApplicationController
  before_filter :authenticate_user!

  def new
    @user = User.new
  end
  
  def list
    @users = User.find_all()
  end

  def show
    puts "USER SHOW CALLED--------------"
    @user = User.find(params[:id])
  end
  
  def create
    puts "USER CREATE CALLED---------------"
    @user.addLike(params[:user])
    redirect_to users_url, :notice => "Added Like"

  end
  
  def update
    @user = User.find(params[:id])
    puts "USER UPDATE CALLED---------------- #{@user.like_name}"
    if @user.update_attributes(params[:user])
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
end
