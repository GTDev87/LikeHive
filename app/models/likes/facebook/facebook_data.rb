class FacebookData
  include Mongoid::Document
  
  field :facebook_id, type: Integer
  embedded_in :facebook_like, :inverse_of => :facebook_data
end