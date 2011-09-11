class LikesController < ApplicationController
  def index
    @searcher = LikeSearcher.new()
    @likes = @searcher.search(params[:search])   
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def show
    @like = LikeQuery.find(params[:id])
  end
end
