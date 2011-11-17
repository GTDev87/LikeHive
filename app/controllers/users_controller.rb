class UsersController < ApplicationController
  def new
    @user = UserCreator.new
    @user.habitation.locations << Zipcode.new
  end
  
  def create
    @user = User.new params[:user]
    @user.build_personality
    @user.build_mailbox
    
    if @user.save
      @user.habitation.save ### monkey patch hack
      login(params[:user][:email], params[:user][:password])
      redirect_to @user, :notice => "Welcome! You have signed up successfully."
    else
      render :new
    end
  end
  
  def list
  end

  def show
    puts "params are #{params}"
    @user = UserQuery.find(params[:id])
    
    number_of_interests = 5
    recommended_users = 5
    
    @like_recommendations = Recommender.new(RandomLikeRecommendationGenerator.new(@user)).get_recommendations(number_of_interests).like_list
    
    user_glimmer = UserRecommendationGlimmer.new(@user)
    user_recommendation = Recommender.new(RandomUserRecommendationGenerator.new(@user)).get_recommendations(recommended_users)
    user_recommendation.accept(user_glimmer)
    @user_peeks = user_glimmer.user_peeks
    authorize! :read, @user
  end
  
  def edit
    @user = UserQuery.find(params[:id])
    authorize! :read, @user
  end
  
  def update
    @user = UserQuery.find(params[:id])
    authorize! :read, @user
    if @user.update_attributes(params[:user]) 
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
end
