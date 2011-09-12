class StringFormatter
  def self.capitalize_words(string_words)
    words = []
    trim_word(string_words).split(/\s+/).each do |word|
      words << word.capitalize
    end
    return words.join(' ')
  end
  
  def self.lowercase(string_words)
    return trim_word(string_words).downcase
  end
  
  def self.split_by_commas(string_words)
    return trim_word(string_words).split(/\s*,\s*/)
  end
private
  def self.trim_word(string_words)
    return string_words.strip
  end
end