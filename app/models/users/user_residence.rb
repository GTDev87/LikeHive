class UserResidence
  include Mongoid::Document

  has_many :locations,as: :locatable, validate: true, autosave: true
  
  embedded_in :user, :inverse_of => :residence
  
  attr_accessible :locations_attributes
  accepts_nested_attributes_for :locations
  
  #validates_presence_of :locations
  #validates :locations, :length => {:minimum => 1}
end