class UserName
  include Mongoid::Document
  
  field :first
  field :last
  
  embedded_in :profile, :inverse_of => :name 
  
  attr_accessible :first, :last
  validates_presence_of :first
end