class Like
  include Mongoid::Document
  field :name, :type => String
  key :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  belongs_to :user_personality, inverse_of: :likes
  
  embeds_one :following, class_name: "LikeFollowing"
  accepts_nested_attributes_for :following
  validates_presence_of :following
  
  attr_accessible :name, :following_attributes
  
  include Sunspot::Mongoid
  searchable do
    text :name
  end
  
  def name=(likename)
    super(StringFormatter.lowercase(likename))
  end    
end
