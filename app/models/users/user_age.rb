class UserAge
  def initialize(user)
    @user = user
  end
  
  def age
    now = DateTime.now.to_date
    dob = @user.date_of_birth
    return now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end