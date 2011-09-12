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
    like.save
    @user.reload#clearly not ideal but a mongoid bug for now
    @user.num_likes = @user.likes.size
  end
  
  def add_multiple_likes(likes_names)
    if likes_names == nil || StringEvaluator.string_is_blank(likes_names)
      return
    end
    StringFormatter.split_by_commas(likes_names).each do |like_name|
      add_like(like_name)
    end
  end
  
  def update_num_likes()
    @user.num_likes = @user.likes.size
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