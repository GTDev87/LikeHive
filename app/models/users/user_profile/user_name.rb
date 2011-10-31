class UserName
  include Mongoid::Document
  
  field :first
  field :last_initial
  
  embedded_in :profile, :inverse_of => :name 
  
  attr_accessible :first, :last_initial
  validates_presence_of :first
end