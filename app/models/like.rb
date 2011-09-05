class Like
  include Mongoid::Document
  field :name, :type => String
  field :num_users, type: Integer, default: 0
  key :name
  has_and_belongs_to_many :users, class_name: "User", inverse_of: :likes
  
  after_save :assign_num_users
  
  def assign_num_users
    self.reload
    self.num_users = self.users.count
  end
  
  #use like_name instead of name as setter/getter
  def like_name=(likename)
    self.name = capitalize_words(likename)
  end

  def like_name
    return self.name 
  end
  
private
  def capitalize_words(string_words)
    words = []
    string_words.split(/\s+/).each do |word|
      words << word.capitalize
    end
    return words.join(' ')
  end
end
