class MessageUserAssigner
  def initialize(message)
    @message = message
  end
  
  def assign_message_to_users()
    message_visitor = MessageUserLinkingVisitor.new(@message)
    @message.message_data.associated_users.accept_user_visitor(message_visitor)
  end
end