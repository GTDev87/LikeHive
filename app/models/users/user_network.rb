class UserNetwork
  include Mongoid::Document

  has_many :contacts, class_name: "User", validate: true, autosave: true
  
  embedded_in :user, :inverse_of => :network
  
  attr_accessible :contacts_attributes
  accepts_nested_attributes_for :contacts
end