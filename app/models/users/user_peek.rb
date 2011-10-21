class UserPeek
  attr_reader :user
  attr_reader :similar_likes
  
  def initialize(user)
    @user = user
    @similar_likes = []
  end
  
  def calculate_similarities(other_user)
    user_intersection = UserIntersection.new(user,other_user)
    @similar_likes = user_intersection.similar_interests
  end
end