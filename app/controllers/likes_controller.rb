class LikesController < ApplicationController
  respond_to :html, :json
  def index
    @searcher = LikeSearcher.new()
    @likes = @searcher.word_search(params[:term])      
    respond_with(@likes) do |format|
      format.json do 
        render json: @likes.map(&:name)
      end
    end
  end
  
  def show
    @like = LikeQuery.find(params[:id])    
  end
end
