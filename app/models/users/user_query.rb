class UserQuery
  def self.find_one_by_name(user_name)
    return User.first(conditions: { name: user_name })
  end
  
  def self.all()
    return User.all
  end
  
  def self.find(find_string)
    return User.find(find_string)
  end  
end