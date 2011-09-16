class UserInterestLocator
  def initialize(user)
    @user = user
  end
  
  def find_like(like_name)
    if @user.likes == nil
      return nil
    end
    @user.likes.each do |like|
      if like.name == like_name
        return like
      end
    end
    return nil
  end
end