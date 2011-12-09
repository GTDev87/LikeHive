class LikeQuery  
  def self.find(find_string)
    return Like.find(find_string)
  end
  
  def self.all()
    return Like.all
  end
  
  def self.find_one_by_name(like_name)
    return Like.first(conditions: { name: like_name })
  end
  
  def self.find_or_create_with_name(like_name)
    like = find_one_by_name(like_name)
    if like == nil
      like = LikeCreator.create(name: like_name)
    end
    return like
  end
  
  def self.query_likes_without_names(name_array)
    return LikeCriteriaQuery.new(Like.not_in(name: name_array))
  end
end