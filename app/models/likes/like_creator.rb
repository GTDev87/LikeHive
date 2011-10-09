class LikeCreator
  def self.create(like_name)
    like = Like.new(like_name)
    like.build_following
    like.save
    return like
  end 
  
  def self.new(like_name)
    like = Like.new(like_name)
    like.build_following
    return like
  end
end