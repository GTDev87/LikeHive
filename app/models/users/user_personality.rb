class UserPersonality
  include Mongoid::Document

  has_many :likes, class_name: "Like"
  accepts_nested_attributes_for :likes
  
  embedded_in :user, :inverse_of => :personality
  after_initialize :initialize_user_personality
  
  attr_reader :user_like_locator

  def initialize_user_personality
    @user_like_locator = UserLikeLocator.new(self)
    @user_like_generator = UserLikeGenerator.new(self)
  end
  
  def get_new_likes(likes_string)
    return @user_like_generator.generate_multiple_likes(likes_string)
  end
  
  def get_new_like(like_string)
    return @user_like_generator.generate_like(like_string)
  end
  
  def find_like(like_name)   
    return @user_like_locator.find_like(like_name)
  end    
end