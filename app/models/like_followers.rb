class LikeFollowers
  def initialize(like)
    @like = like
  end
  
  def recompute_users
    @like.reload
    @like.num_users = @like.users.count
  end
  
  def num_users
    return @like.num_users
  end
  
  def users
    return @like.users
  end
  
  def return_user_names
    if @like.users == nil || @like.users.size == 0
	    return ["No Users"]
    else
	    userArray = Array.new
	    @like.users.each do |user|
	      userArray << user.name
	    end
	    return userArray
    end
  end
  
  def <<(user)
    @like.users << user
    @like.save
  end
end