class LikeFollowing
  include Mongoid::Document

  has_and_belongs_to_many :users, class_name: "User", inverse_of: nil
  embedded_in :like, :inverse_of => :following
  
  accepts_nested_attributes_for :users
  
end