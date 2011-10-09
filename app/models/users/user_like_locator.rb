class UserLikeLocator
  def initialize(user_personality)
    @user_personality = user_personality
  end
  
  def find_like(like_name)
    if @user_personality.likes == nil
      return nil
    end
    @user_personality.likes.each do |like|
      if like.name == like_name
        return like
      end
    end
    return nil
  end
end