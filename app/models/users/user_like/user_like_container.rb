class UserLikeContainer
  attr_accessor :likes
  def initialize(likes)
    @likes = likes
  end
  
  def accept_like_visitor(visitor)
    self.likes.each do |like|
      if !visitor.continue_visit_like(like)
        return
      end
    end
  end
end