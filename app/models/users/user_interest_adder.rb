class UserInterestAdder
  def initialize(user, user_interest_locator)
    @user = user
    @user_interest_locator = user_interest_locator
  end
  
  def add_interest(like_name)
    like_string = LikeString.new(like_name)
    if not like_string.is_valid or @user_interest_locator.find_like(like_name) then 
      return 
    end
    like = LikeQuery.find_one(like_name)
    if like == nil
      like = LikeCreator.create(:name => like_name)
    end
    @user.likes << like
    like.save
    @user.reload#clearly not ideal but a mongoid bug for now
    @user.num_likes = @user.likes.size
  end
end