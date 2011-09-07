class LikesController < ApplicationController
  def index
    @likes = Like.all()
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def display_all_likes
    likes = Like.all()
    puts "displaying all likes : #######################"
    puts "params are #{params[:id]}"
    puts "size_likes = #{likes.size}"
    likes.each do |like|
      puts "found likes are = #{like.id}"
    end
  end
  
  def show
    display_all_likes
    @like = Like.find(params[:id])
  end
end
