class UserPeek
  attr_reader :user, :similar_likes, :handshake
  
  def initialize(user)
    @user = user
    @similar_likes = []
    @handshake = MessageCreator.new_handshake_message
    @handshake.message_data.from = user
  end
  
  def calculate_similarities(other_user)
    user_intersection = UserIntersection.new(user,other_user)
    @similar_likes = user_intersection.similar_interests
    
    #does not belong here
    @handshake.message_data.to = [other_user]
  end
end