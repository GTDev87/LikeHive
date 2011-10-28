class Geolocation
  include Mongoid::Document
  
  field :coordinates, :type => Array
  
  embedded_in :mappable, polymorphic: true
end