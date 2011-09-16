#Note to users of this class please, please, please,please please do not modifiy the document
#like relationships with the accessors through external classes
#try to keep all document modification done in methods added to this class
#this is an attempt to keep the code base clean


class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :name
  key :name
  
  field :num_likes, type: Integer, default: 0
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_and_belongs_to_many :likes, class_name: "Like", inverse_of: :users
  
  after_initialize :initialize_user_interests
  
  attr_accessor :like_name
  attr_accessible :like_name
  
  attr_accessor :like_box
  attr_accessible :like_box
  
  before_save :assign_like
  before_save :assign_multiple_likes
  after_save :update_num_likes#hackish
  
  def initialize_user_interests
    
    
    @user_likes = UserInterests.new(self,UserInterestLocator.new(self),UserInterestAdder.new(self))
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
  
  def update_numlikes
    get_likes.update_numlikes()
  end
end

