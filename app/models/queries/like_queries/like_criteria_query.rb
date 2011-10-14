class LikeCriteriaQuery
  def initialize(like_criteria)
    @like_criteria = like_criteria
  end
  
  def return_all()
    return @like_criteria.all
  end
  
  
  
  def return_n_random(number_of_random)
    like_array = []
    
    random_array =(0..@like_criteria.count-1).sort_by{rand}.slice(0,number_of_random)
    
    random_array.each do |like_index|
      like_found = @like_criteria.skip(like_index).first
      like_array <<  like_found
    end
    return like_array
  end
end