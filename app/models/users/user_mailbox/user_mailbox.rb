class UserMailbox
  include Mongoid::Document
  
  has_and_belongs_to_many :messages, class_name: "Message", validate: true, autosave: true, inverse_of: nil
  
  embedded_in :user, :inverse_of => :mailbox
  
  attr_accessible :messages_attributes
  accepts_nested_attributes_for :messages
end