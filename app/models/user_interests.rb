class UserInterests
  def initialize(user)    
    @user = user
  end
  
  def num_likes
    return @user.num_likes
  end
  
  def likes
    return @user.likes
  end
  
  def return_like_names
    if @user.likes == nil || @user.likes.size == 0
	    return ["No Likes"]
    else
	    likeArray = Array.new
	    @user.likes.each do |like|
	      likeArray << like.name
	    end
	    return likeArray
    end
  end
  
  def add_like(like_name)
    if like_name == nil || StringEvaluator.string_is_blank(like_name) 
      return
    end  
      
    like = find_like(like_name)
    if like == nil
      like = LikeQuery.find_one(like_name)
      if like == nil
        like = LikeCreator.create(:name => like_name)
      end
    end
    @user.likes << like
    @user.reload#clearly not ideal but a mongoid bug for now
    @user.num_likes = @user.likes.count
  end
  
  def <<(like)
    @user.likes << like
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