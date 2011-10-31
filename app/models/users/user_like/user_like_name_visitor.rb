class UserLikeNameVisitor
  attr_reader :name_list
  def initialize
    @name_list = []
  end
  
  def continue_visit_like(like)
    @name_list << like.name
    return true
  end
end