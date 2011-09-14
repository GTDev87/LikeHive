class UserInterestAdder
  def initialize(user)
    @user = user
  end
  
  def add_interest(like_name)
    
    like = LikeQuery.find_one_by_name(like_name)
    if like == nil
      like = LikeCreator.create(:name => like_name)
    end
    @user.likes << like
    like.save
    @user.reload#clearly not ideal but a mongoid bug for now
    @user.num_likes = @user.likes.size
  end
end