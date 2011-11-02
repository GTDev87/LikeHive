class UserLikeLocator
  def initialize(user_like_container)
    @user_like_container = user_like_container
  end
  
  def find_like(like_name)
    if @user_like_container.likes == nil
      return nil
    end
    user_locator_visitor = UserLikeLocatorVisitor.new(like_name)
    @user_like_container.accept_like_visitor(user_locator_visitor)
    return user_locator_visitor.found_like
  end
end