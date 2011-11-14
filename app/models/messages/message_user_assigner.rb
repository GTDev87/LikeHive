class MessageUserAssigner
  def initialize(message)
    @message = message
  end
  
  def assign_message_to_users()
    message_visitor = MessageUserLinkingVisitor.new(@message)
    user_message_array = @message.to | [@message.from]
    UserContainer.new(user_message_array).accept_user_visitor(message_visitor)
  end
end