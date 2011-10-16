class User
  include Mongoid::Document
  authenticates_with_sorcery!

  embeds_one :profile, class_name: "UserProfile"
  accepts_nested_attributes_for :profile
  
  embeds_one :habitation, class_name: "UserHabitation"
  accepts_nested_attributes_for :habitation

  embeds_one :personality, class_name: "UserPersonality"
  accepts_nested_attributes_for :personality

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  
  belongs_to :like_following, inverse_of: :users
  
  key :email
  validates_presence_of :habitation, :personality, :profile
  validates_uniqueness_of :email, :case_sensitive => false

  validates :email, :presence => true, :email => true
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :like_box, :like_name, :habitation_attributes, :personality_attributes, :profile_attributes
  
  attr_accessor :like_name, :like_box
  
  before_save :assign_like
  before_save :assign_multiple_likes  
  
  def email=(email_name)
    self[:email] = StringFormatter.lowercase(email_name)
  end  
  
  def assign_multiple_likes
    #maybe move sanitization up to here
    if @like_box == nil then return end
    likes_names = @like_box
    @like_box = nil
    add_likes(likes_names)
  end
  
  def add_likes(likes_names)
    @personality.get_new_likes(likes_names).each do |like|
      UserLikeLinker.link_user_and_like(self, like)
    end
  end
  
  def assign_like
    #maybe move sanitization up to here and here
    if @like_name == nil then return end
    like_name = @like_name
    @like_name = nil
    add_like(like_name)
  end
  
  def add_like(like_name)
    UserLikeLinker.link_user_and_like(self, @personality.get_new_like(like_name))    
  end
end

