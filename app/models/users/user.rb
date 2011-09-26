#Note to users of this class please, please, please,please please do not modifiy the document
#like relationships with the accessors through external classes
#try to keep all document modification done in methods added to this class
#this is an attempt to keep the code base clean


class User
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  authenticates_with_sorcery!

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  #location information
  # location{zipcode coordinate{lat, long}}
  field :zipcode

  #encapsulate in name class 1:1 maybe
  field :first_name
  field :last_initial
  
  field :female, type: Boolean, default: false
  field :date_of_birth, type: Date
  
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  
  #scary thought combine into embedded document 1:1 class
  field :num_likes, type: Integer, default: 0
  has_and_belongs_to_many :likes, class_name: "Like", inverse_of: :users
  
  #properties
  key :email
  validates_presence_of :first_name, :date_of_birth, :zipcode
  validates_uniqueness_of :email, :case_sensitive => false
  validate :check_zipcode
  validates :email, :presence => true, :email => true
  
  attr_accessible :first_name, :last_initial, :female, :date_of_birth, :email, :password, :password_confirmation, :remember_me, :like_box, :like_name, :zipcode
  
  after_initialize :initialize_user_interests
  attr_accessor :like_name, :like_box
  
  before_save :assign_like, :assign_multiple_likes
  after_save :update_num_likes#hackish
  
  def initialize_user_interests
    @user_likes = UserInterests.new(self,UserInterestLocator.new(self),UserInterestAdder.new(self))
    @user_age = UserAge.new(self)
  end
  
  def email=(email_name)
    self[:email] = StringFormatter.lowercase(email_name)
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
  
  def check_zipcode
    unless StringEvaluator.is_numeric?(self.zipcode) && (self.zipcode.size == 5 || self.zipcode.size == 9)
      unless self.zipcode.size == 10 && self.zipcode[5] == "-" && StringEvaluator.is_numeric?(self.zipcode.sub("-", ""))
        errors.add(:zipcode, "Zipcode is invalid")
      end
    end
  end
end

