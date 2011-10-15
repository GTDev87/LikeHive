class LikeCriteriaQuery
  def initialize(like_criteria)
    @like_criteria = like_criteria
    @criteria_query = CriteriaQuery.new(like_criteria)
  end
  
  def return_all()
    return @criteria_query.return_all
  end
  
  
  
  def return_n_random(number_of_random_likes)
    return @criteria_query.return_n_random(number_of_random_likes)
  end
end