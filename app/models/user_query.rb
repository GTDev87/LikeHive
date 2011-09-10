class UserQuery
  def self.all()
    return User.all
  end
  
  def self.find(find_string)
    return User.find(find_string)
  end
  
  def self.new()
    return User.new
  end
end