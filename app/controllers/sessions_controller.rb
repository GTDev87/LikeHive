class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Signed in successfully."
    else
      flash.now.alert = "Invalid email or password."
      render :new
    end

  end
  
  def destroy
    logout
    redirect_to root_url, :notice => "Signed out"
  end

end
