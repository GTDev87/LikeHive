ActiveSupport::Inflector.inflections do |inflect|
  inflect.singular("message_data", "message_data")
  inflect.plural("message_data", "message_datas")
end

class MessageData
  #make transparent interacted through parent class
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  field :subject
  field :body
  field :time, type: DateTime, default: -> {Time.now}
  
  belongs_to :from, class_name: "User"#one sided has_one :from
  has_and_belongs_to_many :to, class_name: "User", inverse_of: nil #one sided many to many
  
  validates_presence_of :from, :time, :to
  
  attr_accessible :from, :to, :body, :subject

  after_save :assign_messages
  embedded_in :sendable, polymorphic: true

  def associated_users()
    return UserContainer.new(self.to | [self.from])
  end
end