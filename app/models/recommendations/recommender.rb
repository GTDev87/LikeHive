class Recommender  
  def get_recommendations(recommendation_generator, number_of_recommendations)
    return recommendation_generator.generate_recommendations(number_of_recommendations)
  end
end