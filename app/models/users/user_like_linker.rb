class UserLikeLinker
  def self.link_user_and_like(user, like)
    if user == nil || like == nil then return end
    user.personality.likes << like
    like.following.users << user
  end
end