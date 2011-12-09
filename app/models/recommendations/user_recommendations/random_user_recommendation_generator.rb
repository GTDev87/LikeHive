class RandomUserRecommendationGenerator
  def initialize(user)
    @user = user
  end
  
  def generate_recommendations(number_of_users)
    username_visitor = UserUsernameVisitor.new
    @user.network.user_connection_container.accept_user_visitor(username_visitor)
    
    users = UserQuery.query_users_without_username(username_visitor.user_list | [@user.username])
    return UserRecommendation.new(users.query_returner.return_n_random(number_of_users))
  end
end