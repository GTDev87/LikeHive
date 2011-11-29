class MessageCreator
  #untested needs tests
  def self.new_contact_message()
    message = ContactMessage.new
    return message
  end  
  
  def self.new_contact_message_with_parameters(params)
    message = ContactMessage.new params
    return message
  end
  
  def self.new_handshake_message()
    message = HandshakeMessage.new
    return message
  end  
  
  def self.new_handshake_message_with_parameters(params)
    message = HandshakeMessage.new params
    return message
  end
  
  def self.create_accept_message(accepting_user, handshake_user)
    accept_message = MessageCreator.new_contact_message
    accept_message.message_data.to = [handshake_user]
    accept_message.message_data.from = accepting_user
    accept_message.message_data.subject = "[Handshake Accepted] #{accepting_user.username}"
    return accept_message
  end
end