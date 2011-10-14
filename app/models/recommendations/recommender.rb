class Recommender  
  def initialize(recommendation_generator)
    @generator = recommendation_generator
  end
  
  def get_recommendations(number_of_recommendations)
    return @generator.generate_recommendations(number_of_recommendations)
  end
end