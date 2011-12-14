class UserLikeGenerator
  def initialize(user_like_locator)
    @user_like_locator = user_like_locator
  end
  
  def generate_like(like_string)
    return create_like_if_new(like_string)
  end
   
private
  def create_like_if_new(like_name)
    model_string = ModelString.new(like_name)
    if not model_string.is_valid or @user_like_locator.find_like(model_string.string) then return nil end
    return LikeQuery.find_or_create_with_name(like_name)
  end
end