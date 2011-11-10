class UserMessageContainer
  attr_accessor :messages
  def initialize(messages)
    @messages = messages
  end
  
  def accept_message_visitor(visitor)
    @messages.each do |message|
      visitor.visit_message(message)
    end
  end
end