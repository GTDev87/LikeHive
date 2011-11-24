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
      redirect_to profile_path, :notice => "Welcome! You have signed up successfully."
    else
      render :new
    end
  end
  
  def list
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

    create_handshake_message params[:virtual_handshake]
    
    if @user.update_attributes(params[:user])
      redirect_to profile_path
    else
      render profile_edit_path
    end
  end
  
  def create_handshake_message(handshake_param)
    #this code sucks
    if handshake_param != nil
      handshake = MessageCreator.new_handshake_message()
      handshake.message_data.from = current_user
      handshake.message_data.to = [User.find(handshake_param[:message_data_attributes][:to])]
      handshake.message_data.subject = handshake_param[:message_data_attributes][:subject]
      handshake.message_data.body = handshake_param[:message_data_attributes][:body]
      
      @user.virtual_handshake = handshake
        
      flash[:error] = "Handshake Sent" 
    end
  end
end
