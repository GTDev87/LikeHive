class LikeFollowing
  include Mongoid::Document

  has_many :users, class_name: "User"
  embedded_in :like, :inverse_of => :following
  
  accepts_nested_attributes_for :users
  
end