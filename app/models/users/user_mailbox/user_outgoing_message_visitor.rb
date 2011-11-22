class UserOutgoingMessageVisitor
  attr_reader :outgoing_messages
  
  def initialize(user)
    @user = user
    @outgoing_messages = []
  end
  
  def visit_message(message)
    if(message == nil|| message.message_data.from == nil)
      return
    end
    if(message.message_data.from.email == @user.email)
      @outgoing_messages << message
    end
  end
end