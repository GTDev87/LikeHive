class UserMailboxController < ApplicationController
  def new
  end
  
  def create
  end
  
  def list
  end

  def show
    @user = current_user
    @mailbox = current_user.mailbox
    @mailbox.setup_mailbox_folders
  end
  
  def edit
  end
  
  def update
  end
end
