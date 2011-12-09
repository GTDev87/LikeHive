class CriteriaQueryReturner
  def initialize(criteria_query)
    @criteria_query = criteria_query
  end
  
  def return_all()
    return @criteria_query.criteria.all.entries
  end
  
  def return_n_random(number_of_random)
    random_document_array = []
    
    random_array =(0..@criteria_query.criteria.count-1).sort_by{rand}.slice(0,number_of_random)
    
    random_array.each do |index|
      document_found = @criteria_query.criteria.skip(index).first
      random_document_array <<  document_found
    end
    return random_document_array
  end
end