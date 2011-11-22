class HandshakeMessage < Message
  embeds_one :message_data, as: :sendable, validate: true
  accepts_nested_attributes_for :message_data
  validates_presence_of :message_data
  attr_accessible :message_data_attributes
end