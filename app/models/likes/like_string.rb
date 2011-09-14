class LikeString
  attr_reader :string
  
  def initialize(like_string)
    if like_string == nil || StringEvaluator.string_is_blank(like_string)
      @is_valid = false
      return
    end
    @string = StringFormatter.lowercase(like_string)
    @is_valid = true
  end
  
  def is_valid
    return @is_valid
  end
end