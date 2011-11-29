class HandshakeMessage < Message
  embeds_one :message_data, as: :sendable, validate: true
  accepts_nested_attributes_for :message_data
  validates_presence_of :message_data
  attr_accessible :message_data_attributes
  
  around_save :assign_messages  
  
private
  def assign_messages
    if self.message_data.changed?
      yield 
      message_assigner = MessageUserAssigner.new(self)
      message_assigner.assign_message_to_users
    end
  end
end