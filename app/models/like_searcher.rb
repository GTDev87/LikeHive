class LikeSearcher
  #def self.search(search_string)
  #  if(search_string != nil)
  #    return LikeQuery.all_in(search_string)
  #  end
  #  return []
  #end
  def self.search(search_string)    
    search = Sunspot.search(Like) do
      keywords search_string
    end
    
    puts "the serach results are #{search.results}"
    return search.results
  end
end