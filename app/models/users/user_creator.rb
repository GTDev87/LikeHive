class UserCreator
  def self.new()
    user = User.new
    user.build_name
    user.build_age
    user.build_gender
    user.build_residence
    user.build_personality
    return user
  end
end