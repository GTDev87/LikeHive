class LikeCriteriaQuery
  attr_accessor :query_returner
  def initialize(like_criteria)
    @criteria_query = CriteriaQuery.new(like_criteria)
    @query_returner = CriteriaQueryReturner.new(@criteria_query)
  end
end