class RandomUserRecommendationGenerator
  def initialize(user)
    @user = user
  end
  
  def generate_recommendations(number_of_users)
    email_visitor = UserEmailVisitor.new
    @user.network.user_connection_container.accept_user_visitor(email_visitor)
    
    users = UserQuery.query_users_without_email(email_visitor.user_list | [@user.email])
    return UserRecommendation.new(users.query_returner.return_n_random(number_of_users))
  end
end