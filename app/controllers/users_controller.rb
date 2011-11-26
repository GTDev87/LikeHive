class UsersController < ApplicationController
  def new
    @user = UserCreator.new
    @user.habitation.locations << Zipcode.new
  end
  
  def create
    @user = User.new params[:user]
    #encapsulate building
    @user.build_personality
    @user.build_mailbox
    @user.build_network
    
    if @user.save
      @user.habitation.save ### monkey patch hack
      login(params[:user][:email], params[:user][:password])
      redirect_to profile_path, :notice => "Welcome! You have signed up successfully."
    else
      render :new
    end
  end
  
  def show
    @user = current_user
    authorize! :read, @user
    
    number_of_interests = 5
    recommended_users = 5
    
    @like_recommendations = Recommender.new(RandomLikeRecommendationGenerator.new(@user)).get_recommendations(number_of_interests).like_list
    
    @user_interaction = UserRecommendationInteraction.new(@user)
    user_recommendation = Recommender.new(RandomUserRecommendationGenerator.new(@user)).get_recommendations(recommended_users)
    user_recommendation.accept(@user_interaction)
  end
  
  def edit
    @user = current_user
    authorize! :read, @user
  end
  
  def update
    @user = current_user
    authorize! :read, @user

    if @user.update_attributes(params[:user])
      redirect_to profile_path
    else
      render profile_edit_path
    end
  end
end
