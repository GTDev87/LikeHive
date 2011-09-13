class LikeQuery  
  def self.find(find_string)
    return Like.find(find_string)
  end
  
  def self.find_with_name(like_name)
    return Person.find(:all, :conditions => { :name => StringFormatter.lowercase(like_name) })
  end
  
  def self.all()
    return Like.all
  end
  
  def self.find_one(like_name)
    return Like.first(conditions: { name: StringFormatter.lowercase(like_name) })
  end
end