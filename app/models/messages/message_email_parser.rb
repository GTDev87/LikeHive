class MessageEmailParser
  def initialize(string_email_list)
    if string_email_list == nil 
      @email_list = []
    else
      @email_list = StringFormatter.split_by_commas(StringFormatter.lowercase(string_email_list))
    end
  end
  
  def return_user_list()
    user_list = []
    @email_list.each do |email_string|
      user_list << UserQuery.find_user_by_email(email_string)
    end
    return UserContainer.new(user_list)
  end
end