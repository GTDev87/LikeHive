class UserInterestLocator
  def initialize(user_interests)
    @user_interests = user_interests
  end
  
  def find_like(like_name)
    if @user_interests.likes == nil
      return nil
    end
    @user_interests.likes.each do |like|
      if like.name == like_name
        return like
      end
    end
    return nil
  end
end