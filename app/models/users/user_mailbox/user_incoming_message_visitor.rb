class UserIncomingMessageVisitor
  attr_reader :incoming_messages
  
  def initialize(user)
    @user = user
    @incoming_messages = []
  end
  
  def visit_message(message)
    if(message == nil || message.to == nil)
      return
    end
    if(message.to.include?(@user))
      @incoming_messages << message
    end
  end
end