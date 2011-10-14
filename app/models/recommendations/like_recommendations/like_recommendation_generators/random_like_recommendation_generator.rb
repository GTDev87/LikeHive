class RandomLikeRecommendationGenerator
  def initialize(user)
    @user = user
  end
  
  def generate_interests(number_of_interests)
    other_likes = LikeQuery.query_likes_without_names(@user.personality.get_like_names)
    return other_likes.return_n_random(number_of_interests)
  end
end