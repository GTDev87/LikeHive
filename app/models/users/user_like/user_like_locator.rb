class UserLikeLocator
  def initialize(user_personality)
    @user_personality = user_personality
  end
  
  def find_like(like_name)
    if @user_personality.likes == nil
      return nil
    end
    user_locator_visitor = UserLikeLocatorVisitor.new(like_name)
    @user_personality.accept_like_visitor(user_locator_visitor)
    return user_locator_visitor.found_like
  end
end