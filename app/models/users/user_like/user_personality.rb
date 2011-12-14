class UserPersonality
  include Mongoid::Document

  has_and_belongs_to_many :likes, class_name: "Like", inverse_of: nil
  accepts_nested_attributes_for :likes
  
  embedded_in :user, :inverse_of => :personality
  after_initialize :initialize_user_personality
  
  attr_reader :user_like_locator, :user_like_container

  def initialize_user_personality
    @user_like_container = LikeContainer.new(self.likes)
    @user_like_locator = UserLikeLocator.new(@user_like_container)
    @user_like_generator = UserLikeGenerator.new(@user_like_locator)
  end  
  
  def get_new_like(like_string)
    return @user_like_generator.generate_like(like_string)
  end
  
  def find_like(like_name)   
    return @user_like_locator.find_like(like_name)
  end
end