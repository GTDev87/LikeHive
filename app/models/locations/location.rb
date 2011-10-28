class Location
  include Mongoid::Document 
  
  ##THIS LINE OF CODE IS THE CULPRIT
  
  belongs_to :locatable, polymorphic: true, :inverse_of => :locations
end