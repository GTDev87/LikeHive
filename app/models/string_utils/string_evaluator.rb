class StringEvaluator
  def self.string_is_blank(string)
    return /\A\s*\Z/ === string 
  end
  
  def self.is_numeric?(string)
    return /\A\d+\Z/ === string
  end
end