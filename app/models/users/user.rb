#Note to users of this class please, please, please,please please do not modifiy the document
#like relationships with the accessors through external classes
#try to keep all document modification done in methods added to this class
#this is an attempt to keep the code base clean


class User
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :first_name
  field :last_initial
  field :female, type: Boolean, default: false
  field :date_of_birth, type: Date
  
  key :email
  
  field :num_likes, type: Integer, default: 0
  validates_presence_of :first_name, :date_of_birth
  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :first_name, :last_initial, :female, :date_of_birth, :email, :password, :password_confirmation, :remember_me, :like_box, :like_name
  has_and_belongs_to_many :likes, class_name: "Like", inverse_of: :users
  
  after_initialize :initialize_user_interests
  attr_accessor :like_name, :like_box
  
  before_save :assign_like, :assign_multiple_likes
  after_save :update_num_likes#hackish
  
  def initialize_user_interests
    @user_likes = UserInterests.new(self,UserInterestLocator.new(self),UserInterestAdder.new(self))
    @user_age = UserAge.new(self)
  end
  
  def get_likes()    
    return @user_likes
  end
  
  def get_age()
    return @user_age
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
  
  def update_numlikes
    get_likes.update_numlikes()
  end
end

