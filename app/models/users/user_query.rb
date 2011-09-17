class UserQuery 
  def self.all()
    return User.all
  end
  
  def self.find(find_string)
    return User.find(find_string)
  end  
  
  def self.find_user_by_email(email_addr)
    return User.first(conditions: { email: StringFormatter.lowercase(email_addr) })
  end
end