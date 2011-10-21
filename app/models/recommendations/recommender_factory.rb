class RecommenderFactory
  def self.create_recommender(recommendation_generator)
    return Recommender.new(recommendation_generator)
  end
end