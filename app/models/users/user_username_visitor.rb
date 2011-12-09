class UserUsernameVisitor
  attr_reader :user_list
  
  def initialize()
    @user_list = []
  end
  
  def visit_user(user)
    @user_list << user.username
  end
end