class MessageEmailParser
  def initialize(string_email_list)
    @email_list = StringFormatter.split_by_commas(StringFormatter.lowercase(string_email_list))
  end
  
  def accept_user_visitor(user_visitor)
    @email_list.each do |email_string|
      user_visitor.visit_user(UserQuery.find_user_by_email(email_string))
    end
  end
end