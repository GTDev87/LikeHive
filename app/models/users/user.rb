class User
  include Mongoid::Document
  authenticates_with_sorcery!

  #encapsulate in name class 1:1 maybe
  embeds_one :name, class_name: "UserName"
  accepts_nested_attributes_for :name
  
  embeds_one :age, class_name: "UserAge"
  accepts_nested_attributes_for :age
  
  embeds_one :gender, class_name: "UserGender"
  accepts_nested_attributes_for :gender
  
  embeds_one :residence, class_name: "UserResidence"
  accepts_nested_attributes_for :residence

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  
  #scary thought combine into embedded document 1:1 class
  field :num_likes, type: Integer, default: 0
  has_and_belongs_to_many :likes, class_name: "Like", inverse_of: :users
  
  #properties
  key :email
  validates_presence_of :name, :age, :gender, :residence
  validates_uniqueness_of :email, :case_sensitive => false

  validates :email, :presence => true, :email => true
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :like_box, :like_name, :name_attributes, :age_attributes, :gender_attributes, :residence_attributes
  
  after_initialize :initialize_user_interests
  attr_accessor :like_name, :like_box
  
  before_save :assign_like
  before_save :assign_multiple_likes
  after_save :update_num_likes#hackish
  
  def initialize_user_interests
    @user_likes = UserInterests.new(self,UserInterestLocator.new(self),UserInterestAdder.new(self))
  end
  
  def email=(email_name)
    self[:email] = StringFormatter.lowercase(email_name)
  end
  
  def get_likes()    
    return @user_likes
  end  
  
  def update_num_likes
    get_likes.update_num_likes
  end
  
  def assign_multiple_likes
    get_likes.add_multiple_likes(@like_box)
  end
  
  def assign_like
    get_likes.add_like(@like_name)
  end  
end

