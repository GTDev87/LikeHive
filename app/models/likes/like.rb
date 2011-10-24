class Like
  include Mongoid::Document
  include Sunspot::Mongoid  
  field :name, :type => String
  key :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  embeds_one :following, class_name: "LikeFollowing"
  accepts_nested_attributes_for :following
  validates_presence_of :following
  
  attr_accessible :name, :following_attributes
  
  searchable do
    text :name
  end
  
  def name=(likename)
    super(StringFormatter.lowercase(likename))
  end    
end