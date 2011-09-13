class UserInterests
  def initialize(user)    
    @user = user
    #@userInterestLocator = userInterestLocator
    @user_interest_locator = UserInterestLocator.new(self)
    #@userAdder = userAdder
    @user_adder = UserInterestAdder.new(user, @user_interest_locator)
  end
  
  def num_likes
    return @user.num_likes
  end
  
  def likes
    return @user.likes
  end
   
  def add_like(like_name)
    @user_adder.add_interest(like_name)
  end
  
  def add_multiple_likes(likes_names)
    likes_string = LikeString.new(likes_names)
    if not likes_string.is_valid then return end
      
    StringFormatter.split_by_commas(likes_string.string).each do |like_name|
      @user_adder.add_interest(like_name)
    end
  end
  
  def update_num_likes()
    @user.num_likes = @user.likes.size
  end
  
  def <<(like)
    @user.likes << like
  end
  
  def find_like(like_name)   
    return @user_interest_locator.find_like(like_name)
  end  
end