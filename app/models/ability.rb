class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new#Guest user account
    
    can :read, User do |page_user|
      page_user == user
    end
  end
end
