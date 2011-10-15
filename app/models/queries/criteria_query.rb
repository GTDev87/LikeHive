class CriteriaQuery
  def initialize(criteria)
    @criteria = criteria
  end
  
  def return_all()
    return @criteria.all
  end
  
  def return_n_random(number_of_random)
    random_document_array = []
    
    random_array =(0..@criteria.count-1).sort_by{rand}.slice(0,number_of_random)
    
    random_array.each do |index|
      document_found = @criteria.skip(index).first
      random_document_array <<  document_found
    end
    return random_document_array
  end
end