class Like
  include Mongoid::Document
  field :name, :type => String
  field :numUsers, type: Integer
  key :name
  has_and_belongs_to_many :users, class_name: "User", inverse_of: :likes 
end
