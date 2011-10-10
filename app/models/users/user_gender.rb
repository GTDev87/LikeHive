class UserGender
  include Mongoid::Document

  field :female, type: Boolean, default: false
  
  embedded_in :user, :inverse_of => :gender
  
  attr_accessible :female
  validates_inclusion_of :female, :in => [true,false]
end