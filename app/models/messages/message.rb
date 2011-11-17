class Message
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  field :subject
  field :body
  field :time, type: DateTime, default: -> {Time.now}
  
  belongs_to :from, class_name: "User"#one sided has_one :from
  has_and_belongs_to_many :to, class_name: "User", inverse_of: nil #one sided many to many
  
  validates_presence_of :from, :time
  validate :validate_to_users
  
  attr_accessible :from, :to, :body, :subject, :to_username_list
  attr_accessor :to_username_list

  after_save :assign_messages

  def associated_users()
    return UserContainer.new(self.to | [self.from])
  end

private
  #NOTE TO SELF: CLEAN THIS CODE UP
  def parse_to_list
    if @to_username_list == nil then return false end
    temp_username_list = @to_username_list
    @to_username_list = nil
    
    user_visitor = UserVisitor.new(@to)
    MessageUsernameParser.new(temp_username_list).return_user_list.accept_user_visitor(user_visitor)
    return true
  end
  
  def assign_messages
    if !parse_to_list then return end
    
    if self.changed?
      message_assigner = MessageUserAssigner.new(self)
      message_assigner.assign_message_to_users
    end
  end
  
  def validate_to_users
    if @to == nil
      errors.add(:to, "To can't be blank")
      return
    end
    
    parsed_sent_to_array = []
    user_visitor = UserVisitor.new(parsed_sent_to_array)
    MessageUsernameParser.new(@to_username_list).return_user_list.accept_user_visitor(user_visitor)

    sent_to_array = parsed_sent_to_array | @to
    
    if sent_to_array.empty?
      errors.add(:to, "users sent to not valid")
      return
    end
  end
end