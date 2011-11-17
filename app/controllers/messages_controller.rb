class MessagesController < ApplicationController
  def new
    @message = MessageCreator.new
    @message.from = current_user
  end
  
  def create
    @message = MessageCreator.new_with_parameters  params[:message]
    @message.from = current_user
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
