class UserIncomingMessageVisitor
  attr_reader :incoming_messages
  
  def initialize(user)
    @user = user
    @incoming_messages = []
  end
  
  def visit_message(message)
    if(message == nil || message.message_data.to == nil)
      return
    end
    
    if(message.message_data.to.include?(@user))
      @incoming_messages << message
    end
  end
end