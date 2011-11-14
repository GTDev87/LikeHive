class MessageUserLinker
  def link_user_and_message(user, message)
    user.mailbox.messages << message 
  end
end