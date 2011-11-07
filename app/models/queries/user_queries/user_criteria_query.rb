class UserCriteriaQuery
  attr_accessor :query_returner
  def initialize(user_criteria)
    @criteria_query = CriteriaQuery.new(user_criteria)
    @query_returner = CriteriaQueryReturner.new(@criteria_query)
  end
end