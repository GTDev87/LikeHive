class UserMailbox
  include Mongoid::Document
  
  has_and_belongs_to_many :messages, class_name: "Message", validate: true, autosave: true, inverse_of: nil
  
  embedded_in :user, :inverse_of => :mailbox
  
  attr_accessible :messages_attributes
  accepts_nested_attributes_for :messages
  
  after_initialize :initialize_user_inbox, :initialize_user_outbox
  
  def initialize_user_inbox
    #UserInbox.new(self.messages.where())
  end
  
  def initialize_user_outbox
    #UserOutbox.new(self.messages.where())
  end
end