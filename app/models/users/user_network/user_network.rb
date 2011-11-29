class UserNetwork
  include Mongoid::Document

  has_and_belongs_to_many :contacts, class_name: "User", validate: true, autosave: true, inverse_of: nil
  
  embedded_in :user, :inverse_of => :network
  
  attr_accessor :virtual_contact
  
  attr_reader :user_connection_container
  
  attr_accessible :contacts_attributes
  accepts_nested_attributes_for :contacts
  
  after_save :notify_and_assign_contacts
  
  after_initialize :initialize_network
  
  def initialize_network
    @user_connection_container = UserContainer.new(self.contacts)
  end
  
private 
  def notify_and_assign_contacts
    if @virtual_contact == nil then return end
    temp_contact = @virtual_contact
    @virtual_contact = nil
    
    handshake_user = UserQuery.find_user_by_username(temp_contact)
    UserContactLinker.link_contacts(self.user, handshake_user)
    MessageCreator.create_accept_message(self.user, handshake_user).save!
  end
end