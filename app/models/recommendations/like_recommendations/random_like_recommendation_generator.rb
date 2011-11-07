class RandomLikeRecommendationGenerator
  def initialize(user)
    @user = user
  end
  
  def generate_recommendations(number_of_interests)
    like_visitor = UserLikeNameVisitor.new
    @user.personality.user_like_container.accept_like_visitor(like_visitor)
    
    other_likes = LikeQuery.query_likes_without_names(like_visitor.name_list)
    return LikeRecommendation.new(other_likes.query_returner.return_n_random(number_of_interests))
  end
end