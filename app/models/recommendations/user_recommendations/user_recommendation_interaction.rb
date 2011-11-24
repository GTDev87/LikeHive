class UserRecommendationInteraction
  
  attr_reader :user_links
  
  def initialize(user)
    @user = user
    @user_links = []
  end
  
  def visit(other_user)
    link = UserLink.new(@user)
    link.create_link_interface(other_user)
    @user_links << link
  end
end