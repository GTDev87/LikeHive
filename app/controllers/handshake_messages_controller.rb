class HandshakeMessagesController < ApplicationController  
  def create
    #this code sucks FIX THIS LATER
    if params[:handshake_message] != nil
      handshake = MessageCreator.new_handshake_message()
      handshake.message_data.from = current_user
      handshake.message_data.to = [User.find(params[:handshake_message][:message_data_attributes][:to])]
      handshake.message_data.subject = params[:handshake_message][:message_data_attributes][:subject]
      handshake.message_data.body = params[:handshake_message][:message_data_attributes][:body]
      flash[:error] = "Handshake Sent" 
      
      handshake.save!
    end
    
    redirect_to profile_path
  end

  def show
    @message = MessageQuery.find(params[:id])
    authorize! :read, @message
  end
end
