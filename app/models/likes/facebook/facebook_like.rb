class FacebookLike < Like
  embeds_one :facebook_data, class_name: "FacebookData"
  
  after_initialize :initialize_facebook_data 
  
private
  def initialize_facebook_data
    if self.facebook_data == nil
      self.create_facebook_data
    end
  end
end