class UserEmailComparingVisitor
  attr_reader :found_user
  
  def initialize(user)
    @user = user
    @found_user = false
  end
  
  def visit_user(user)
    if user != nil && user.email == @user.email
      @found_user = true
    end
  end
end