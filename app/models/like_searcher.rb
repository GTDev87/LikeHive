class LikeSearcher
  def self.search(search_string)    
    
    Like.all.each do |like|
      puts "the liek found was #{like.name}"
    end
    
    search = Like.search do
      keywords search_string
    end
    
    puts "the serach results are #{search.results}"
    return search.results
  end
end