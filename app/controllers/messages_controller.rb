class MessagesController < ApplicationController
  def new
    @message = MessageCreator.new
    @message.from = current_user
  end
  
  def create
    @message = MessageCreator.new_with_parameters  params[:message]
    @message.from = current_user
    puts "the messages attributes are #{@message.attributes}"
    @message.save!
    if @message.save
      puts "message saved!!!!!!!!!!!!!!!"
      redirect_to mailbox_path, :notice => "You have successfully sent the message"
    else
      puts "message not SAVEDDDDDDDDDDDDDDDDDDDDDDDDDDDD"
      render :new
    end
  end
  
  def list
  end

  def show
  end
  
  def edit
  end
  
  def update
  end
end
