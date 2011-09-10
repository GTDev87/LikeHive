class StringFormatter
  def self.capitalize_words(string_words)
    words = []
    string_words.split(/\s+/).each do |word|
      words << word.capitalize
    end
    return words.join(' ')
  end
  
  def self.lowercase(string_words)
    return string_words.downcase
  end
end