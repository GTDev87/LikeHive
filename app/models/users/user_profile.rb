class UserProfile
  include Mongoid::Document

  embeds_one :name, class_name: "UserName"
  accepts_nested_attributes_for :name
  
  embeds_one :age, class_name: "UserAge"
  accepts_nested_attributes_for :age
  
  embeds_one :gender, class_name: "UserGender"
  accepts_nested_attributes_for :gender
  
  validates_presence_of :name, :age, :gender
  validates_associated :name, :age, :gender
  
  embedded_in :user, :inverse_of => :profile
  
  attr_accessible :name_attributes, :age_attributes, :gender_attributes
end