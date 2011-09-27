class UserBuilder
  def initialize(user = nil)
    if user == nil
      @user = User.new
    else
      @user = user
    end
  end
  
  def with_attributes(attributes)
    @user.update_attributes(attributes)
    return self
  end
  
  def with_user_name(name_attributes)
    if(@user.name == nil)
      @user.name = UserName.new
    end
    @user.build_name(name_attributes)
    return self
  end
  
  def build()
    return @user
  end
  
  def create()
    @user.save!
    return @user
  end
end