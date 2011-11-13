class UserVisitor
  def initialize(field)
    @field = field
  end
  
  def visit_user(user)
    if(user != nil && !@field.include?(user))
      @field << user
    end
  end
end