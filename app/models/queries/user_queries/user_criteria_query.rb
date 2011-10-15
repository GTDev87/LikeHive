class UserCriteriaQuery
  def initialize(user_criteria)
    @user_criteria = user_criteria
    @criteria_query = CriteriaQuery.new(user_criteria)
  end
  
  def return_all()
    return @criteria_query.return_all
  end
  
  
  
  def return_n_random(number_of_random_likes)
    return @criteria_query.return_n_random(number_of_random_likes)
  end
end