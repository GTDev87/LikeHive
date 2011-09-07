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
  
  
  attr_accessor :like_name
  attr_accessible :like_name
  after_save :assign_like
  
  def return_like_names
    if self.likes == nil || self.likes.size == 0
	    return ["No Likes"]
    else
	    likeArray = Array.new
	    self.likes.each do |like|
	      likeArray << like.name
	    end
	    return likeArray
    end
  end
  
  def assign_like
    if @like_name
      
      like = find_like(@like_name)
      
      if like == nil
        like = Like.first(conditions: { name: @like_name })
      
        if like == nil
          like = Like.create(:name => @like_name)
        end
      end
      self.likes << like
      self.reload#clearly not ideal but a mongoid bug for now
      self.num_likes = self.likes.count
    end 
  end
  
  def find_like(like_name)    
    self.likes.each do |like|
      if like.name == like_name
        return like
      end
    end
    return nil
  end
end

