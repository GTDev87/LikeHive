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

  
  def assign_like
    puts "$$$$$$$$$$$ calling assign_like1 with like_name:[#{@like_name}] $$$$$"
    if @like_name
      self.likes << Like.find_or_create_by(:name => @like_name)
      puts "THIS WAS CALLED IN SERVER################"
      #puts "the file was saved? #{self.save}"
    end
  end
  
  def has_like?(like_name)
    self.likes.each do |like|
      if like.name.upcase == like_name.upcase
        return true
      end
    end
    return false
  end
  
  def find_like(like_name)    
    self.likes.each do |like|
      if like.name == like_name
        return like
      end
    end
    return nil
  end
  
  def add_like!(like_name)
      like = nil
      like = find_like(like_name)
      if like == nil
        like = Like.create(name: like_name)
        self.num_likes = self.num_likes + 1
        self.likes << like
        self.save!
        self.reload#clearly not ideal but a mongoid bug for now
      end
  end
  

end

