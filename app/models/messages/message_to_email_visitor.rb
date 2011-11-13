class MessageToEmailVisitor
  def initialize(field)
    @field = field
  end
  
  def visit_email_string(email_string)
    user = UserQuery.find_user_by_email(email_string)
    if(user != nil && !@field.include?(user))
      @field << user
    end
  end
end