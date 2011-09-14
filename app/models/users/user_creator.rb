class UserCreator
  def self.new()
    return User.new
  end
  
  def self.create!(like_name)
    return User.create!(like_name)
  end
end