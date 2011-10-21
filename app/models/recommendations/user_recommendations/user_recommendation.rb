class UserRecommendation
  attr_reader :user_list

  def initialize(user_list)
    @user_list = user_list
  end
  
  def accept(visitor)
    @user_list.each do |user|
      visitor.visit(user)
    end
  end
end