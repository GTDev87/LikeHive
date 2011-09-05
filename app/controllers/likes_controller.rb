class LikesController < ApplicationController
  def index
    @likes = Like.find(params[:id])
  end
  
  def new
    
  end
  
  def create
    
  end
end
