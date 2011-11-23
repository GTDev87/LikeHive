class HandshakeMessagesController < ApplicationController
  def new
  end
  
  def create
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
