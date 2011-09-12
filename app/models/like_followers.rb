class LikeFollowers
  def initialize(like)
    @like = like
  end
  
  def recompute_users
    @like.num_users = @like.users.count
  end
  
  def num_users
    return @like.num_users
  end
  
  def users
    return @like.users
  end
  
  def <<(user)
    @like.users << user
    @like.save
    @like.num_users = @like.users.count
    @like.save #this may be a temporary patch
  end
end