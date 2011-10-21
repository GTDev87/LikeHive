class UserRecommendationGlimmer
  
  attr_reader :user_peeks
  
  def initialize(user)
    @user = user
    @user_peeks = []
  end
  
  def visit(other_user)
    current_peek = UserPeek.new(other_user)
    current_peek.calculate_similarities(@user)
    @user_peeks << current_peek
  end
end