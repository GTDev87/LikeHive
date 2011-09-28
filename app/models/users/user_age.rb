class UserAge
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  field :date_of_birth, type: Date
  
  embedded_in :user, :inverse_of => :age
  
  attr_accessible :date_of_birth
  validates_presence_of :date_of_birth
  
  def age_in_years
    now = DateTime.now.to_date
    dob = self.date_of_birth
    return now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end