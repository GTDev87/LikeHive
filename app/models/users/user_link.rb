class UserLink
  attr_reader :user, :other_user, :similar_likes, :handshake
  
  def initialize(user)
    @user = user
    @similar_likes = []
  end
  
  def create_link_interface(other_user)
    #kinda Crappy
    @other_user = other_user
    user_intersection = UserIntersection.new(user,other_user)
    @similar_likes = user_intersection.similar_interests
    @handshake = create_handshake()
  end
  
private
  def create_handshake
    handshake = MessageCreator.new_handshake_message
    handshake.message_data.from = @user
    handshake.message_data.to = [@other_user]
    handshake.message_data.subject = "[Handshake Extended] #{@user.username}"
    return handshake
  end
end