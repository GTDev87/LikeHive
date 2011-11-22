#interface object... maybe define interface
class Message
  include Mongoid::Document
  
  #messages must have :message_data
  after_initialize :initialize_message_data
  
  def initialize_message_data
    if self.message_data == nil
      self.build_message_data
    end
  end
end