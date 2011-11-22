class ConnectionMessageUsernameParser
  def initialize(string_username_list)
    if string_username_list == nil 
      @username_list = []
    else
      @username_list = StringFormatter.split_by_commas(string_username_list)
    end
  end
  
  def return_user_list()
    user_list = []
    @username_list.each do |username_string|
      user_list << UserQuery.find_user_by_username(username_string)
    end
    return UserContainer.new(user_list)
  end
end