class UserMailboxController < ApplicationController  
  def show
    @user = current_user
    @mailbox = current_user.mailbox
    @mailbox.setup_mailbox_folders
  end
end
