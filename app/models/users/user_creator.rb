class UserCreator
  def self.new()
    user = User.new
    user.build_profile
    user.profile.build_name
    user.profile.build_age
    user.profile.build_gender
    user.build_residence
    user.build_personality
    return user
  end
end