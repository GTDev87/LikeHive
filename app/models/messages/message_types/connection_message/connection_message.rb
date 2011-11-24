class ConnectionMessage < Message
  validate :validate_to_users
  
  attr_accessible :to_username_list
  attr_accessor :to_username_list

  around_save :assign_messages
  
  embeds_one :message_data, as: :sendable, validate: false
  accepts_nested_attributes_for :message_data
  validates_presence_of :message_data
  attr_accessible :message_data_attributes

private
  #NOTE TO SELF: CLEAN THIS CODE UP
  def parse_to_list
    if @to_username_list == nil then return false end
    temp_username_list = @to_username_list
    @to_username_list = nil
    
    user_visitor = UserVisitor.new(self.message_data.to)
    ConnectionMessageUsernameParser.new(temp_username_list).return_user_list.accept_user_visitor(user_visitor)
    return true
  end
  
  def assign_messages    
    if parse_to_list() || self.message_data.changed?
      yield
      message_assigner = MessageUserAssigner.new(self)
      message_assigner.assign_message_to_users
    end
  end
  
  def validate_to_users
    if self.message_data.to == nil#move this down into message_data
      errors.add(:to, "To can't be blank")
      return
    end
    
    parsed_sent_to_array = []
    user_visitor = UserVisitor.new(parsed_sent_to_array)
    ConnectionMessageUsernameParser.new(self.to_username_list).return_user_list.accept_user_visitor(user_visitor)

    sent_to_array = parsed_sent_to_array | self.message_data.to
    
    if sent_to_array.empty?
      errors.add(:to, "users sent to not valid")
      return
    end
  end
end