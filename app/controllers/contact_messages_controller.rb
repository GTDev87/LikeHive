class ContactMessagesController < ApplicationController
  def new
    @message = MessageCreator.new_contact_message
    if not params[:reply_message] == nil
      prev_message = MessageQuery.find(params[:reply_message])
      @message.to_username_list = prev_message.message_data.from.username
      @message.message_data.subject = prev_message.message_data.subject
      @message.message_data.body = prev_message.message_data.body
    end
    @message.message_data.from = current_user
  end
  
  def create
    @message = MessageCreator.new_contact_message_with_parameters params[:contact_message]
    @message.message_data.from = current_user
    if @message.save
      redirect_to mailbox_path, :notice => "You have successfully sent the message"
    else
      render new_contact_message_path
    end
  end
  
  def show
    @message = MessageQuery.find(params[:id])
    authorize! :read, @message
  end
end
