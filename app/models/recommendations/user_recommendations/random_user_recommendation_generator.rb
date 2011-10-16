class RandomUserRecommendationGenerator
  def initialize(user)
    @user = user
  end
  
  def generate_recommendations(number_of_users)
    users = UserQuery.query_users_without_email([@user.email])
    return users.return_n_random(number_of_users)
  end
end