class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new#Guest user account
    
    can :read, User do |page_user|
      page_user == user
    end
    
    can :read, Message do |page_message|
      comparing_visitor = UserEmailComparingVisitor.new(user)
      page_message.associated_users.accept_user_visitor(comparing_visitor)
      comparing_visitor.found_user
    end
  end
end
