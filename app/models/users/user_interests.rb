class UserInterests
  def initialize(user)    
    @user = user
    #@userInterestLocator = userInterestLocator
    @user_interest_locator = UserInterestLocator.new(self)
    #@userAdder = userAdder
    @user_adder = UserInterestAdder.new(user)
  end
  
  def num_likes
    return @user.num_likes
  end
  
  def likes
    return @user.likes
  end
   
  def add_like(like_name)
    add_like_if_new(like_name)
  end
  
  def add_multiple_likes(likes_names)
    likes_string = ModelString.new(likes_names)
    if not likes_string.is_valid then return end
      
    StringFormatter.split_by_commas(likes_string.string).each do |like_name|
      add_like_if_new(like_name)
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
  
private
  def add_like_if_new(like_name)
    like_string = ModelString.new(like_name)
    if not like_string.is_valid or @user_interest_locator.find_like(like_name) then 
      return 
    end
    @user_adder.add_interest(like_name)
  end
end