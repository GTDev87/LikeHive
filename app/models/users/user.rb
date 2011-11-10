class User
  include Mongoid::Document
  authenticates_with_sorcery!

  embeds_one :profile, class_name: "UserProfile"
  accepts_nested_attributes_for :profile
  attr_accessible :profile_attributes
  
  embeds_one :habitation, class_name: "UserHabitation"
  accepts_nested_attributes_for :habitation
  attr_accessible :habitation_attributes

  embeds_one :personality, class_name: "UserPersonality"
  accepts_nested_attributes_for :personality
  attr_accessible :personality_attributes

  embeds_one :mailbox, class_name: "UserMailbox"
  accepts_nested_attributes_for :mailbox
  attr_accessible :mailbox_attributes

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  
  key :email
  validates_presence_of :habitation, :personality, :profile, :mailbox
  validates_uniqueness_of :email, :case_sensitive => false

  validates :email, :presence => true, :email => true
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :like_box, :like_name
  
  attr_accessor :like_name, :like_box
  
  after_save :assign_like
  after_save :assign_multiple_likes  
  
  
  after_create :initialize_mailbox#HACK KILL THIS LATER WHEN MONGOID IS COMPETNENT
    
  def initialize_mailbox
    #####################HACK THIS IS A TEMPORARY METHOD TILL MONGOID FIX #900 ###################
    #######################HACK NEED TO FIND WAY OF AUTOINITIALIZING MAILBOX#################
    if self.mailbox == nil
      self.create_mailbox
      self.mailbox.user = self
      self.mailbox.save!
    end
  end
   
  def email=(email_name)
    self[:email] = StringFormatter.lowercase(email_name)
  end  
  
  def assign_multiple_likes
    #maybe move sanitization up to here
    if @like_box == nil then return end
    likes_names = @like_box
    @like_box = nil
    add_likes(likes_names)
  end
  
  def add_likes(likes_names)
    @personality.get_new_likes(likes_names).each do |like|
      UserLikeLinker.link_user_and_like(self, like)
    end
  end
  
  def assign_like
    #maybe move sanitization up to here and here
    if @like_name == nil then return end
    like_name = @like_name
    @like_name = nil
    add_like(like_name)
  end
  
  def add_like(like_name)
    UserLikeLinker.link_user_and_like(self, self.personality.get_new_like(like_name))    
  end
end

