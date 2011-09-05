module UsersHelper
    def self.returnLikes(user)
    
      if user.likes == nil
	return ["No Likes"]
      else
	likeArray = Array.new
	user.likes.each do |like|
	  likeArray << like.name
	end
	return likeArray
      end
    end
end
