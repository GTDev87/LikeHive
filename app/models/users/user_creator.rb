class UserCreator
  def self.new()
    return User.new
  end
  
  def self.create!(user_name)
    return User.create!(user_name)
  end
end