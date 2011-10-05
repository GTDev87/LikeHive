class Location
  include Mongoid::Document
  
  field :latitude
  field :longitude
  belongs_to :locatable, polymorphic: true
end