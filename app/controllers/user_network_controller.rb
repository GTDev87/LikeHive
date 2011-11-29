class UserNetworkController < ApplicationController
  def update
    @user = current_user
    @network = @user.network
    @network.virtual_contact = params[:contact]
    
    if @network.save
      redirect_to mailbox_path, :notice => "You have successfully sent the message"
    else
      #do not redirect
    end
  end
end