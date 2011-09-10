class Like
  include Mongoid::Document
  field :name, :type => String
  field :num_users, type: Integer, default: 0
  key :name
  has_and_belongs_to_many :users, class_name: "User", inverse_of: :likes
  
  after_save :assign_num_users
  
  include Sunspot::Mongoid
  searchable do
    string :name
  end
  
  def assign_num_users
    get_followers.recompute_users
  end
  
  def get_followers
    if @like_followers == nil  
      @like_followers = LikeFollowers.new(self)
    end
    return @like_followers
  end
  
  def name=(likename)
    super(StringFormatter.lowercase(likename))
  end    
end
