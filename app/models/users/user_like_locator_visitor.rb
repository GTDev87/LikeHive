class UserLikeLocatorVisitor
  attr_reader :found_like
  def initialize(like_name)
    @like_name = like_name
  end
  
  def continue_visit_like(like)
    if(@like_name == like.name)
      @found_like = like
      return false
    end
    return true
  end
end