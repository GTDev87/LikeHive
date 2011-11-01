class UserLikeGenerator
  def initialize(user_like_locator)
    @user_like_locator = user_like_locator
  end
  
  def generate_like(like_string)
    return create_like_if_new(like_string)
  end
  
  def generate_multiple_likes(like_string)
    like_model_string = ModelString.new(like_string)
    if not like_model_string.is_valid then return [] end
    like_array = []
    StringFormatter.split_by_commas(like_model_string.string).each do |like_name|
      new_like = create_like_if_new(like_name)
      unless new_like == nil then like_array << new_like end
    end
    return like_array
  end
  
private
  def create_like_if_new(like_name)
    model_string = ModelString.new(like_name)
    if not model_string.is_valid or @user_like_locator.find_like(model_string.string) then return nil end
    return LikeQuery.find_or_create_with_name(like_name)
  end
end