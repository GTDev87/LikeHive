class SessionsController < ApplicationController  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to profile_path, :notice => "Signed in successfully."
    else
      redirect_to root_url, :notice => "Invalid email or password."
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Signed out"
  end
end
