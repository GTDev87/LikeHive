class UserHabitation
  include Mongoid::Document

  has_many :locations, class_name: "Location" , as: :locatable, validate: true, autosave: true
  
  embedded_in :user, :inverse_of => :habitation
  
  #attr_accessible :locations_attributes
  accepts_nested_attributes_for :locations
end