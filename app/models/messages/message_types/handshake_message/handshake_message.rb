class HandshakeMessage < Message
  embeds_one :message_data, as: :sendable, validate: true
  accepts_nested_attributes_for :message_data
  validates_presence_of :message_data
  attr_accessible :message_data_attributes
  
  around_save :assign_messages
  
  def create_accept_message
    accept_message = MessageCreator.new_connection_message
    accept_message.message_data.to = [self.message_data.from]
    accept_message.message_data.from = self.message_data.to.first
    accept_message.message_data.subject = "[Handshake Accepted] #{accept_message.message_data.from.username}"
    return accept_message
  end
  
private
  def assign_messages
    if self.message_data.changed?
      yield 
      message_assigner = MessageUserAssigner.new(self)
      message_assigner.assign_message_to_users
    end
  end
end