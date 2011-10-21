class UserIntersection
  def initialize(user1, user2)
    @user1 = user1
    @user2 = user2
  end
  
  def similar_interests()
    like_intersection = @user1.personality.likes & @user2.personality.likes
    return like_intersection
  end
end