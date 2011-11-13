class Location
  include Mongoid::Document 
  
  belongs_to :locatable, polymorphic: true, :inverse_of => :locations
end