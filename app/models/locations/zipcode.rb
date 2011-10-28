class Zipcode < Location
  include Mongoid::Document
  
  field :number

  validate :check_zipcode
  validates_presence_of :number
  
  embeds_one :geolocation, as: :mappable
  
  
  def check_zipcode
    if self.number == nil
      errors.add(:number, "Zipcode is invalid")
      return
    end
    unless StringEvaluator.is_numeric?(self.number) && (self.number.size == 5 || self.number.size == 9)
      unless self.number.size == 10 && self.number[5] == "-" && StringEvaluator.is_numeric?(self.number.sub("-", ""))
        errors.add(:number, "Zipcode is invalid")
      end
    end
  end
end