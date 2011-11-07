class UserMailboxController < ApplicationController
  def new
  end
  
  def create
  end
  
  def list
  end

  def show
    @mailbox = current_user.mailbox
  end
  
  def edit
  end
  
  def update
  end
end
