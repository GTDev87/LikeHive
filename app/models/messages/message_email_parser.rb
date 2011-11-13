class MessageEmailParser
  def initialize(string_email_list)
    @email_list = StringFormatter.split_by_commas(StringFormatter.lowercase(string_email_list))
  end
  
  def accept_email_string(email_string_visitor)
    @email_list.each do |email_string|
      email_string_visitor.visit_email_string(email_string)
    end
  end
end