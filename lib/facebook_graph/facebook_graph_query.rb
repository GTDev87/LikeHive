class FacebookGraphQuery
  def query_facebook_like(like_name)
    pages = FbGraph::Page.search(like_name)
    while 1
      if pages.empty?
        break
      else
        
      end
      pages = pages.next
    end
  end
end