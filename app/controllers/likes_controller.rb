class LikesController < ApplicationController
  def index
    @searcher = LikeSearcher.new()
    @likes = @searcher.search(params[:search])   
  end
  
  def show
    @like = LikeQuery.find(params[:id])    
  end
end
