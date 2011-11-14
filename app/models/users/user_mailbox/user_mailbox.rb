class UserMailbox
  include Mongoid::Document
  
  has_and_belongs_to_many :messages, class_name: "Message", inverse_of: nil
  accepts_nested_attributes_for :messages
  attr_accessible :message_attributes
  
  embedded_in :user, :inverse_of => :mailbox
  
  attr_reader :inbox, :outbox
  
  def setup_mailbox_folders
    @user_message_container = UserMessageContainer.new(self.messages)
    
    user_incoming = UserIncomingMessageVisitor.new(self.user)
    @user_message_container.accept_message_visitor(user_incoming)
    @inbox = UserFolder.new(user_incoming.incoming_messages)
    
    user_outgoing = UserOutgoingMessageVisitor.new(self.user)
    @user_message_container.accept_message_visitor(user_outgoing)
    @outbox = UserFolder.new(user_outgoing.outgoing_messages)
  end
end