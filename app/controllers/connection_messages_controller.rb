class ConnectionMessagesController < ApplicationController
  def new
   
    @message = MessageCreator.new_connection_message
    if not params[:reply_message] == nil
      prev_message = MessageQuery.find(params[:reply_message])
      @message.to_username_list = prev_message.message_data.from.username
      @message.message_data.subject = prev_message.message_data.subject
      @message.message_data.body = prev_message.message_data.body
    end
    @message.message_data.from = current_user
  end
  
  def create
    @message = MessageCreator.new_connection_message_with_parameters params[:connection_message]
    @message.message_data.from = current_user
    if @message.save
      redirect_to mailbox_path, :notice => "You have successfully sent the message"
    else
      render :new
    end
  end
  
  def list
  end

  def show
    @message = MessageQuery.find(params[:id])
    authorize! :read, @message
  end
  
  def edit
  end
  
  def update
  end
end
