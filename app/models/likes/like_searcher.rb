class LikeSearcher
  def search(search_string)
    if StringEvaluator.string_is_blank(search_string)
      return []
    end
    search = Like.solr_search do
      keywords search_string
      paginate :page => 1, :per_page => 10
    end

    return search.results
  end
end