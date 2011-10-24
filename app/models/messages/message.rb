class Message
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  field :subject
  field :body
  field :time, type: DateTime
  
  belongs_to :from, class_name: "User"#one sided has_one :from
  has_and_belongs_to_many :to, class_name: "User", inverse_of: nil #one sided many to many
  
  validates_presence_of :from, :to, :time
end