class UserQuery
  def self.find_one(like_name)
    return User.first(conditions: { name: like_name })
  end
  
  def self.all()
    return User.all
  end
  
  def self.find(find_string)
    return User.find(find_string)
  end  
end