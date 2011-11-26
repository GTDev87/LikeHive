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
end