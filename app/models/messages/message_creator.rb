class MessageCreator
  #untested
  def self.new()
    message = Message.new
    return message
  end  
  
  def self.new_with_parameters(params)
    message = Message.new params
    return message
  end
end