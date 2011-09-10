class HomeController < ApplicationController
  def index
    @users = UserQuery.all
    @likes = LikeQuery.all
  end

end
