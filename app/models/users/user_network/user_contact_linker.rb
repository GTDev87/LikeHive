class UserContactLinker
  def self.link_contacts(user, other_user)
    #need to check is user already exists
    user.network.contacts << other_user
    other_user.network.contacts << user
  end
end