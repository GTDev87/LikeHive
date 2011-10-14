class LikeRecommender  
  def recommend_interests(like_recommendation_generator, number_of_interests)
    return like_recommendation_generator.generate_interests(number_of_interests)
  end
end