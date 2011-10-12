class UserResidence
  include Mongoid::Document

  has_many :locations,as: :locatable, validate: true, autosave: true
  
  embedded_in :user, :inverse_of => :residence
  
  attr_accessible :locations_attributes
  accepts_nested_attributes_for :locations
end