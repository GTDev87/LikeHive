class UsersController < ApplicationController
  def new
    @user = UserCreator.new
    @user.habitation.locations << Zipcode.new
  end
  
  def create
    @user = User.new params[:user]
    @user.build_personality
  
    #puts "params = #{params}"
    #puts
    
    #@user.habitation.locations.each do |loc|
    #  puts "before location save = #{loc.attributes}"
    #end
    
    if @user.save
      @user.habitation.save ### monkey patch hack
      login(params[:user][:email], params[:user][:password])
      redirect_to root_url, :notice => "Welcome! You have signed up successfully."
    else
      render :new
    end
  end
  
  def list
    @users = UserQuery.all()
  end

  def show
    @user = UserQuery.find(params[:id])
    number_of_interests = 5
    recommended_users = 5
    
    like_recommender = Recommender.new(RandomLikeRecommendationGenerator.new(@user))
    @like_recommendations = like_recommender.get_recommendations(number_of_interests).like_list
    
    user_recommender = Recommender.new(RandomUserRecommendationGenerator.new(@user))
    user_recommendation = user_recommender.get_recommendations(recommended_users)
    user_glimmer = UserRecommendationGlimmer.new(@user)
    user_recommendation.accept(user_glimmer)
    @user_peeks = user_glimmer.user_peeks
    
    authorize! :read, @user
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = UserQuery.find(params[:id])
    if @user.update_attributes(params[:user]) 
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
end
