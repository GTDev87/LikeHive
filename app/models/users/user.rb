class User
  include Mongoid::Document
  authenticates_with_sorcery!

  embeds_one :name, class_name: "UserName"
  accepts_nested_attributes_for :name
  
  embeds_one :age, class_name: "UserAge"
  accepts_nested_attributes_for :age
  
  embeds_one :gender, class_name: "UserGender"
  accepts_nested_attributes_for :gender
  
  embeds_one :residence, class_name: "UserResidence"
  accepts_nested_attributes_for :residence

  embeds_one :personality, class_name: "UserPersonality"
  accepts_nested_attributes_for :personality

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  
  belongs_to :like_following, inverse_of: :users
  
  key :email
  validates_presence_of :name, :age, :gender, :residence, :personality
  validates_uniqueness_of :email, :case_sensitive => false

  validates :email, :presence => true, :email => true
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :like_box, :like_name, :name_attributes, :age_attributes, :gender_attributes, :residence_attributes, :personality_attributes
  
  attr_accessor :like_name, :like_box
  
  after_save :assign_like
  after_save :assign_multiple_likes  
  
  def email=(email_name)
    self[:email] = StringFormatter.lowercase(email_name)
  end  
  
  def assign_multiple_likes
    if @like_box == nil then return end
    likes_names = @like_box
    @like_box = nil
    
    @personality.get_new_likes(likes_names).each do |like|
      UserLikeLinker.link_user_and_like(self, like)
    end
  end
  
  def assign_like
    if @like_name == nil then return end
    like_name = @like_name
    @like_name = nil
    
    UserLikeLinker.link_user_and_like(self, @personality.get_new_like(like_name))
  end  
end

