class StringEvaluator
  def self.string_is_blank(string)
    return /^\s*$/ === string 
  end
end