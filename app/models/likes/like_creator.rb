class LikeCreator
  def self.create(like_name)
    return Like.create(like_name)
  end 
  
  def self.new(like_name)
    return Like.new(like_name)
  end
end