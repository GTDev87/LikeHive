class Message
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  field :subject
  field :body
  field :time, type: DateTime
  
  belongs_to :from, class_name: "User"#one sided has_one :from
  has_and_belongs_to_many :to, class_name: "User", inverse_of: nil #one sided many to many
  
  validates_presence_of :from, :to, :time
  
  attr_accessible :to_email_list
  attr_accessor :to_email_list
  
  before_validation :parse_to_list

  after_save :assign_messages

private
  def parse_to_list
    if @to_email_list == nil then return end
    temp_email_list = @to_email_list
    @to_email_list = nil
    
    user_visitor = UserVisitor.new(self.to)
    email_parser = MessageEmailParser.new(temp_email_list)
    email_parser.accept_user_visitor(user_visitor)
  end
  
  def assign_messages
    if self.changed?
      
    end
  end
end