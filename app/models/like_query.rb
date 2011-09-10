class LikeQuery
  def self.all_in(search_string)
    if(search_string != nil)
      return Like.all_in(name: [StringFormatter.lowercase(search_string)])
    end
    return []
  end
  
  def self.find(find_string)
    return Like.find(find_string)
  end
  
  def self.all()
    return Like.all
  end
  
  def self.find_one(like_name)
    return Like.first(conditions: { name: like_name })
  end
  
  def self.create(like_name)
    return Like.create(like_name)
  end  
end