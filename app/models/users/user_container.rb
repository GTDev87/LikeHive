class UserContainer
  def initialize(user_list)
    @user_list = user_list
  end
  
  def accept_user_visitor(user_visitor)
    @user_list.each do |user|
      user_visitor.visit_user(user)
    end
  end
end