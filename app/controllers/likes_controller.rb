class LikesController < ApplicationController
  def index
    @likes = LikeSearcher.search(params[:search])   
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def show
    @like = LikeQuery.find(params[:id])
  end
end
