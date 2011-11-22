class MessageCreator
  #untested needs tests
  def self.new_connection_message()
    message = ConnectionMessage.new
    return message
  end  
  
  def self.new_connection_message_with_parameters(params)
    message = ConnectionMessage.new params
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