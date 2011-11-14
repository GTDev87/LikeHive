class MessageUserLinkingVisitor
  def initialize(message)
    @message = message
  end
  
  def visit_user(user)
    user.mailbox.messages <<  @message
  end
end